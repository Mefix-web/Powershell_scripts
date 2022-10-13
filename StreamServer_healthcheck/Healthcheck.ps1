### Script has been written to monitor Disk and Service
### Script is sending email notification every 5 minutes whenever:
### 1. Disk reach 10% or less of free space
### 2. One of Service change status to stopped
### 
### Copyrights: Radoslaw Zudzin
### Added Daily check function 9 May 2020
### Added Automatic start service when it goes down 4 June 2020

######################################################################################################################
############################################ Set ini values ##########################################################

# Continue even if there are errors 
$ErrorActionPreference = "Continue"; 
 
# Set your warning and critical thresholds 
$percentWarning = 15; 
$percentCritcal = 10;
 
# EMAIL PROPERTIES 
 # Set the recipients of the report. 
  $users = "<User1@gmail.com>"
  $CC1 = "<CC1@gmail.com>"
  $CC2 = "<CC2@gmail.com>"
  $CC3 = "<CC3@gmail.com>"
  $CC4 = "<CC4@gmail.com>"
 
# REPORT PROPERTIES 
# Servername
    $server = $env:computername
    $DTQP ="StreamServe PROD_1"
    $datetime = Get-Date -Format "dd-MM-yyyy_HHmmss"; 
    $reportPath = "PATH where generate report";  
    $reportName = "StreamServeReport_$(get-date -format ddMMyyyy).html";
    $Report = $reportPath + $reportName 

#Set colors for table cell backgrounds 
$redColor = "#FF0000" 
$orangeColor ="#FFCC00" 
$YellowColor = "#ffff66"
$whiteColor = "#FFFFFF" 
$greenColor = "#00FF00"
$Functioncolor ="#66a3ff"

# Count if computer has low disk space.  Do not send report if less than 1. 
$i = 0 

# Remove the report if it has already been run today so it does not append to the existing report 
If (Test-Path $Report) 
    { 
        Remove-Item $Report 
    } 

# Cleanup old files.. 
$Daysback = "-7" 
$CurrentDate = Get-Date; 
$DateToDelete = $CurrentDate.AddDays($Daysback); 
Get-ChildItem $reportPath | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item; 

$emptyRow = "<table><br> </table>"

function MailSchedule {
   # Once a day send a status mail to show this monitoring is running and providing the current application status.
#    $HOURS = @(08,12,16)
    $HOURS = @(06)
    $MINUTES = 0..5

    if ( $HOURS.Contains((Get-Date -Format HH) / 1) ) {
        if ( $MINUTES.Contains((Get-Date -Format mm) / 1) ) {
            Write-Host "Sending email on scheduled hours."
            #$script:Mail = "1"
            $i++
        } # End if
    } # End if
    Return $i
} # End function

################################################# Reporting Disk Usage ######################################
Function CheckDiskSpace {
# Create and write HTML Header of report 
$titleDate = get-date -uformat "%A %m-%d-%Y" 
$header = " 
  <html> 
  <head> 
  <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> 
  <title>$DQTP Report</title> 
  <STYLE TYPE='text/css'> 
  <!-- 
  td { 
   font-family: Calibri; 
   font-size: 12px; 
   border-top: 1px solid #999999; 
   border-right: 1px solid #999999; 
   border-bottom: 1px solid #999999; 
   border-left: 1px solid #999999; 
   padding-top: 0px; 
   padding-right: 0px; 
   padding-bottom: 0px; 
   padding-left: 0px; 
  } 
  body { 
   margin-left: 5px; 
   margin-top: 5px; 
   margin-right: 0px; 
   margin-bottom: 10px; 
   table { 
   border: thin solid #000000; 
  } 
  --> 
  </style> 
  </head> 
  <body> 
  <table width='100%'> 
  <tr bgcolor='#548DD4'> 
  <td colspan='7' height='30' align='center'> 
  <font face='calibri' color='#003399' size='4'><strong>$DTQP Report $titledate</strong></font> 
  </td> 
  </tr> 
  </table> 
" 
 Add-Content $Report $header 
 
# Create and write Table header for report 
 $tableHeader = " 
 <table width='100%'><tbody> 
 <tr bgcolor=#548DD4> 
 <td width='10%' align='center'>Server</td> 
 <td width='5%'  align='center'>Drive</td> 
 <td width='5%' align='center'>Drive Label</td> 
 <td width='5%' align='center'>Total Capacity(GB)</td> 
 <td width='5%' align='center'>Used Capacity(GB)</td> 
 <td width='5%' align='center'>Free Space(GB)</td> 
 <td width='5%'  align='center'>Freespace %</td> 
 </tr> 
" 
Add-Content $Report $tableHeader 
  
# Start processing disk space 
 
$disks = Get-WmiObject -ComputerName $server -Class Win32_LogicalDisk -Filter "DriveType = 3" 
$server = $server.toupper() 
foreach($disk in $disks) 
 { 
  Write-host "Processing: " $disk         
	$deviceID = $disk.DeviceID; 
    $volName = $disk.VolumeName; 
	[float]$size = $disk.Size; 
	[float]$freespace = $disk.FreeSpace;  
	$percentFree = [Math]::Round(($freespace / $size) * 100); 
	$sizeGB = [Math]::Round($size / 1073741824, 2); 
	$freeSpaceGB = [Math]::Round($freespace / 1073741824, 2); 
        $usedSpaceGB = $sizeGB - $freeSpaceGB; 
        $color = $greenColor; 

# Set background color to Orange if just a warning 
 if($percentFree -lt $percentWarning -and $deviceID -ne 'E:')       
	{ 
	$color = $orangeColor
    Write-host -ForegroundColor Magenta "The value of percentFree for volume $deviceID is $percentFree"  
	# Set background color to Red if space is Critical 
		if($percentFree -lt $percentCritcal -and $deviceID -ne 'E:') 
		{ 
		$color = $redColor 
		$i++
        Write-host -ForegroundColor Red "The value of percentFree for volume $deviceID is $percentFree"
		} 
	}
 elseif($percentFree -lt 30 -and $deviceID -eq 'E:')
 { 
	$color = $orangeColor
    Write-host -ForegroundColor Magenta "The value of percentFree for volume $deviceID is $percentFree"  
	# Set background color to Red if space is Critical 
		if($percentFree -lt 25 -and $deviceID -eq 'E:') 
		{ 
		$color = $redColor 
		$i++
        Write-host -ForegroundColor Red "The value of percentFree for volume $deviceID is $percentFree"
		} 
	}
 # end if Percent free
	# Create table data rows  
    Write-Host -ForegroundColor DarkYellow "The Value of color is $color"
    $dataRow = " 
		 <tr> 
		 <td width='10%'>$server</td> 
		 <td width='5%' align='center'>$deviceID</td> 
		 <td width='10%' >$volName</td> 
		 <td width='10%' align='center'>$sizeGB</td> 
		 <td width='10%' align='center'>$usedSpaceGB</td> 
		 <td width='10%' align='center'>$freeSpaceGB</td> 
		 <td width='5%' bgcolor=`'$color`' align='center'>$percentFree</td> 
		 </tr>  " 
    Add-Content $Report $dataRow; 
    Write-Host -ForegroundColor DarkYellow "$server $deviceID percentage free space = $percentFree"; 
    
 } # End for each disk 
 

    # Create table at end of report showing legend of colors for the critical and warning 
     #$tableDescription = " 
     #<table width='50%'> 
     #<tr bgcolor='White'> 
     #   <td width='10%' align='center' bgcolor=$greenColor>OK</td> 
     #   <td width='40%' align='center' bgcolor=$orangeColor>Warning level than $percentWarning % free spac</td> 
     #   <td width='40%' align='center' bgcolor=$redColor>Critical less than $percentCritcal % free space</td> 
     #</tr>
     #</table> 
    #" 
     #Add-Content $Report $tableDescription 
     Add-Content $Report "</body></html>" 
     Add-Content $Report $emptyRow
 Return $i
 } # End Function checkDiskspace

###########################################################################################################
######################################### Processing Servives #############################################

Function CheckServices {
    $ii = 0
    $Files = Get-ChildItem -Path "Provide PATH here" -name
    Foreach ($file in $files)
     {  $file2process = "Provide PATH here" + $file
        $LongServiceName = $File.TrimEnd(".txt")
        if ($LongServiceName.StartsWith("M_")) {$Functioncolor ='#dd99ff'}
        if ($LongServiceName.StartsWith("S_")) {$Functioncolor ='#ffbb99'}
        $Servicename = $LongServicename.Substring(2)
        Write-host "Processing the file:  $file2process"
        # Create service table header style
        $header = " 
          <html> 
          <head> 
          <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> 
          <title>HC Services</title> 
          <STYLE TYPE='text/css'> 
          <!-- 
            td { 
               font-family: Calibri; 
               font-size: 12px; 
               border-top: 1px solid #999999; 
               border-right: 1px solid #999999; 
               border-bottom: 1px solid #999999; 
               border-left: 1px solid #999999; 
               padding-top: 0px; 
               padding-right: 0px; 
               padding-bottom: 0px; 
               padding-left: 0px; 
            } 
            body { 
               margin-left: 5px; 
               margin-top: 5px; 
               margin-right: 0px; 
               margin-bottom: 10px; 
               table { 
               border: thin solid #000000; 
            } -->      
          </style> 
          </head> 
          <body> 
            <table width='100%'> 
                <tr bgcolor= $Functioncolor> 
                    <td colspan='7' height='30' align='center'> 
                        <font face='calibri' color='#003399' size='4'><strong>$Servicename</strong></font> 
                    </td> 
                </tr> 
            </table> 
    " 
     Add-Content $Report $header 

    $tableHeader = " 
    <table width='100%'><tbody> 
        <tr bgcolor=#548DD4> 
            <td width='2%' align='center'>Status</td> 
             <td width='8%'  align='center'>Startup Type</td>
            <td width='8%'  align='center'>Service</td> 
            <td width='3%' align='center'>Server</td> 
        </tr> 
    " 
    Add-Content $Report $tableHeader
 
    # Start processing Service
    $servicescontent = Get-Content $file2process
     foreach ($Service in $servicescontent ) {
        # Write-Host "246 Service is $Service"
        $getservice = Get-WmiObject -Query "select * from win32_service where displayname='$service'" -ComputerName $server| Select Name, StartMode, State, DisplayName
        $Status = $getservice.State;
        $Displayname = $getservice.DisplayName; 
        $StartUpType = $getservice.StartMode 
        # Write-Host  "251 Displayname  is $Displayname   StartUpType is $StartUpType  Status is $Status "

        # Set default background color
        $color = $greenColor;
        # Set cell color to red if status is Stopped 
              if($Status -eq 'Stopped' -And $StartUpType -eq 'Auto') 
                { 
                $color = $redColor 
                $ii++
                Write-host -ForegroundColor Red "The service $Displayname has the state $Status "
                Write-host -ForegroundColor Red "The value of ii is: $ii"
                Start-Service $Displayname
               }
               if($Status -eq 'Stopped' -And $StartUpType -eq 'Manual') 
                { 
                $color = $YellowColor 
                }  
        # Create table data rows  
        $dataRow = " 
          <tr> 
          <td width='15%' bgcolor=`'$color`' align='center'>$Status</td> 
          <td width='15%' bgcolor=`'$color`' align='center'>$StartUpType</td>
          <td width='500%' align='center'>$Displayname</td> 
          <td width='20%' align='center'>$server</td> 
          </tr> 
        " 
        # Write-Host "270 Datarow is: $dataRow"
        Add-Content $Report $dataRow; 
        Write-Host -ForegroundColor DarkYellow "271 $Displayname is $Status"; 
        
    } # end for each Service
     Add-Content $Report $emptyRow
     } #end foreach file
Return $ii 
} # End function Checkservices

Function SendMail {
    # Send Notification if alert $i is greater than 0 
    if ($iii -gt 0 -Or $Needmail -eq 1) 
    { 
        foreach ($user in $users) 
        { 
          Write-Host "Sending Email notification to $user " 
   
           $smtpServer = "smtprelay-eur1.philips.com" 
           $smtp = New-Object Net.Mail.SmtpClient($smtpServer) 
           $msg = New-Object Net.Mail.MailMessage 
           $msg.To.Add($user) 
           $msg.CC.Add($CC1)
           $msg.CC.Add($CC2)
           $msg.CC.Add($CC3)
           $msg.CC.Add($CC4)
           $msg.From = "Email_from_who@gmail.com" 
           If($Needmail -eq 1){
           $msg.Subject = "$DTQP $Server Daily Check Report $titledate"
           }
           else {
           $msg.Subject = "$DTQP $Server Error - Check Report $titledate" 
           }
                $msg.IsBodyHTML = $true 
                $msg.Body = get-content $Report 
          $smtp.Send($msg) 
                $body = "" 
          } # foreach ($user in $users)
      } # End if ($iii -gt 0 -Or $Needmail -eq 1)
  } #End function SendMail
  

  $Needmail = MailSchedule
  Write-Host "Mail indicator is:  $Needmail"
  $i = CheckDiskSpace
  Write-Host "Mail indicator na CheckDiskspace is:  $i"
  $ii = CheckServices
  Write-Host "Mail indicator na CheckServices is:  $ii"
  $iii = $i + $ii
  Write-Host -ForegroundColor Yellow "Mail indicator before entering Sendmail function:  $iii"
  SendMail