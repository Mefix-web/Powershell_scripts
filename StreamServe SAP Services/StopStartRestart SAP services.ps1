

#arrays
#Setting path of Startupfile
$StartupfileMP1 = 'PATH_TO_MP1'
$StartupfileMBP = 'PATH_TO_MBP'
$StartupfileWPP = 'PATH_TO_WPP'

#Name of Services MP1 are alphabetical
#$ContentMP1[0] #HS_Batch_PRD
#$ContentMP1[1] #HS_PRD
#$ContentMP1[2] #HS_RFC_PRD
#Name of Services MBP are alphabetical
#$ContentMBP[0] #HS_I-Imaging_Batch_PRD
#$ContentMBP[1] #HS_I-Imaging_PRD
#$ContentMBP[2] #HS_I-Imaging_RFC_PRD
#Name of Services WPP are alphabetical
#$ContentWPP[0] #PH_Batch_PRD
#$ContentWPP[1] #PH_PRD
#$ContentWPP[2] #PH_RFC_PRD
#$ContentWPP[3] #PH_V002_Batch_PRD
#$ContentWPP[4] #PH_V002_PRD
#$ContentWPP[5] #PH_V002_RFC_PRD


function Stop-Menu
#Complete menu to STOP Spool Services
{
     cls
     Write-Host "================(SAP Name)-(Service Name)================" 
     Write-Host "1: Select number 1 to STOP MBP - HS_I-Imaging."
     Write-Host "2: Select number 2 to STOP MP1 - HS_PRD."
     Write-Host "3: Select number 3 to STOP WPP - PH + PH_PHV2."
     Write-Host "4: Select number 4 to STOP an Environment."
     Write-Host "Q: Press 'Q' to quit."
}

function Start-Menu
#Complete menu to START Spool Services
{
     cls
     Write-Host "================(SAP Name)-(Service Name)================" 
     Write-Host "1: Select number 1 to START MBP - HS_I-Imaging."
     Write-Host "2: Select number 2 to START MP1 - HS_PRD."
     Write-Host "3: Select number 3 to START WPP - PH + PH_PHV2."
     Write-Host "4: Select number 4 to START an Environment."
     Write-Host "Q: Press 'Q' to quit."
}

function Restart-Menu
#Complete menu to Restart Spool Services
{
     cls
     Write-Host "================(SAP Name)-(Service Name)================" 
     Write-Host "1: Select number 1 to RESTART MBP - HS_I-Imaging."
     Write-Host "2: Select number 2 to RESTART MP1 - HS_PRD."
     Write-Host "3: Select number 3 to RESTART WPP - PH + PH_PHV2."
     Write-Host "4: Select number 4 to RESTART an Environment."
     Write-Host "Q: Press 'Q' to quit."
}

function Menu
#Main menu to choose what to do with Spool Services
{
     param (
           [string]$Title2 = 'Welcome to Spool Services restart script'
     )
     cls
     $whoami = whoami
     Write-Host "================ Hello $whoami!================ "
     Write-Host "========= $Title2 ========="
     Write-Host "1: Select number 1 for STOP Spool Services."
     Write-Host "2: Select number 2 for START Spool Services."
     Write-Host "3: Select number 3 for RESTART Spool Services"
     Write-Host "Q: Press 'Q' to quit."
}

Function Stop-Type
{
do
{
     Stop-Menu
     $stop = Read-Host "Please select which Spool Services you want to STOP: "
     switch ($stop)
     #Asking user to select Spool Service to STOP
     #Every Option has changing Startup to Manual Type and Stopping Service
     #If user will answer with other option than 1/2/3/4/5 or quit(q) then he will back to the menu
     {
           '1' {
                cls
                $oneSTOP = Read-Host 'Are you sure you want to STOP MBP - HS_I-Imaging? (Y/N)'
                if ($oneSTOP -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to STOP MBP - HS_I-Imaging..."
                    Write-Host "Checking service Startup Type of MBP Spool Services"
                    #Clearing file for having the freshest information of StartType
                    Clear-Content -path $StartupfileMBP
                    #Getting StartType of services
                    $ServicesMBP = @(Get-Service -name  "HS_I-Imaging_RFC_PRD").StartType
                    #Putting StartType of services into txt file
                    $ServicesMBP >> $StartupfileMBP
                    #Setting content from StartupFile of every SAP
                    $ContentMBP = Get-Content -Path $StartupfileMBP

                    Sleep 3
                            if ($ContentMBP -eq 'Automatic')
                        {
                            Set-Service -Name HS_I-Imaging_RFC_PRD -StartupType Manual
                            Sleep 2
                            Stop-Service -Name HS_I-Imaging_RFC_PRD
                        }
                        else
                        {
                            Stop-Service -Name HS_I-Imaging_RFC_PRD
                            sleep 2
                        }
                }
                elseif ($oneSTOP -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }


           } '2' {
                cls
                $twoSTOP = Read-Host 'Are you sure you want to STOP MP1 - HS_PRD? (Y/N)'
                if ($twoSTOP -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to stop MP1 - HS_PRD..."
                    Write-Host "Checking service Startup Type of MP1 Spool Services"
                    #Clearing file for having the freshest information of StartType
                    Clear-Content -path $StartupfileMP1
                    #Getting StartType of services
                    $ServicesMP1 = @(Get-Service -name "HS_RFC_PRD").StartType
                    #Putting StartType of services into txt file
                    $ServicesMP1 >> $StartupfileMP1
                    #Setting content from StartupFile of every SAP
                    $ContentMP1 = Get-Content -Path $StartupfileMP1
                    Sleep 3
                            if ($ContentMP -eq 'Automatic')
                        {
                            Set-Service -Name HS_RFC_PRD -StartupType Manual
                            Sleep 2
                            Stop-Service -Name HS_RFC_PRD
                        }
                        else
                        {
                            Stop-Service -Name HS_RFC_PRD
                        }
                }
                elseif ($twoSTOP -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           } '3' {
                cls
                $threeSTOP = Read-Host 'Are you sure you want to STOP WPP - PH_RFC_PRD + PH_V002_RFC_PRD? (Y/N)'
                if ($threeSTOP -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to stop WPP - PH_RFC_PRD + PH_V002_RFC_PRD..."
                    Write-Host "Checking service Startup Type of WPP Spool Services"
                    #Clearing file for having the freshest information of StartType
                    Clear-Content -path $StartupfileWPP
                    #Getting StartType of services
                    $ServicesWPP = @(Get-Service -name "PH_RFC_PRD", "PH_V002_RFC_PRD").StartType
                    #Putting StartType of services into txt file
                    $ServicesWPP >> $StartupfileWPP
                    #Setting content from StartupFile of every SAP
                    $ContentWPP = Get-Content -Path $StartupfileWPP
                    Sleep 3
                            if ($ContentWPP[0] -eq 'Automatic')
                        {
                             Set-Service -Name PH_RFC_PRD -StartupType Manual
                             Sleep 2
                             Stop-Service -Name PH_RFC_PRD
                        }
                                else
                        {
                            Stop-Service -Name PH_RFC_PRD
                        }

                        if ($ContentWPP[1] -eq 'Automatic')
                        {
                            Set-Service -Name PH_V002_RFC_PRD -StartupType Manual
                            Sleep 2
                            Stop-Service -Name PH_V002_RFC_PRD
                        }
                        else
                        {
                            Stop-Service -Name PH_V002_RFC_PRD
                        }
                }
                elseif ($threeSTOP -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           } '4' {
                cls
                $fourSTOP = Read-Host 'Are you sure you want to STOP Environment? (Y/N)'
                if ($fourSTOP -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to STOP Production Environment"
                    Sleep 3
                    Write-Host "Setting Service into Manual Startup Type"
                    Set-Service -name Hamachi2Svc -StartupType Manual
                    Sleep 2
                    stop-service -name Hamachi2Svc
                    Sleep 2
                }
                elseif ($fourSTOP -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           }'q' {
                return
           }   
           #({[string]$stop -ne '1' -or '2' -or '3' -or '4' -or '5' -or 'q'})
              #  {
              # Write-Host
              # Write-Host "You have typed wrong letter - going back to menu." 
              # Write-Host "Please choose option 1/2/3/4/5 or quit(q)"
              # Sleep 6
              #  }
     }
}
until ($input -eq 'q')
}

Function Start-Type
{
do
{
     Start-Menu
     $start = Read-Host "Please select which Spool Services you want to START: "
     switch ($start)
     #Asking user to select Spool Service to START
     #Every Option has changing Startup to Automatic Type and Starting Service
     #If user will answer with other option than 1/2/3/4/5 or quit(q) then he will back to the menu
     {
           '1' {
                cls
                $oneSTART = Read-Host 'Are you sure you want to START MBP - HS_I-Imaging_RFC_PRD? (Y/N)'
                if ($oneSTART -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to START MBP - HS_I-Imaging_RFC_PRD..."
                    Write-Host "Checking service Startup Type of MBP Spool Services"
                    #Setting content from StartupFile of every SAP service StartUp
                    $ContentMBP = Get-Content -Path $StartupfileMBP
                    Sleep 3
                    if ($ContentMBP -eq 'Automatic')
                    {
                        Start-Service -Name HS_I-Imaging_RFC_PRD
                        Sleep 2
                        Set-Service -Name HS_I-Imaging_RFC_PRD -StartupType Automatic
                    }
                    else
                    {
                        Start-Service -Name HS_I-Imaging_RFC_PRD
                    }
                }
                elseif ($oneSTART -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }


           } '2' {
                cls
                $twoSTART = Read-Host 'Are you sure you want to START MP1 - HS_PRD? (Y/N)'
                if ($twoSTART -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to start MP1 - HS_RFC_PRD..."
                    Write-Host "Checking service Startup Type of MBP Spool Services"
                    #Setting content from StartupFile of every SAP service StartUp
                    $ContentMBP = Get-Content -Path $StartupfileMBP
                    Sleep 3
                    if ($ContentMP1 -eq 'Automatic')
                    {
                        Start-Service -Name HS_RFC_PRD
                        Sleep 2
                        Set-Service -Name HS_RFC_PRD -StartupType Automatic
                    }
                    else
                    {
                        Start-Service -Name HS_RFC_PRD
                    }
                }
                elseif ($twoSTART -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           } '3' {
                cls
                $threeSTART = Read-Host 'Are you sure you want to START WPP - PH_RFC_PRD + PH_V002_RFC_PRD? (Y/N)'
                if ($threeSTART -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to start WPP - PH_RFC_PRD + PH_V002_RFC_PRD..."
                    Write-Host "Checking service Startup Type of MBP Spool Services"
                    #Setting content from StartupFile of every SAP service StartUp
                    $ContentMBP = Get-Content -Path $StartupfileMBP
                    Sleep 3
                    if ($ContentWPP[0] -eq 'Automatic')
                    {
                        Start-Service -Name PH_RFC_PRD
                        Sleep 2
                        Set-Service -Name PH_RFC_PRD -StartupType Automatic
                    }
                    else
                    {
                        Start-Service -Name PH_RFC_PRD
                    }
                    if ($ContentWPP[1] -eq 'Automatic')
                    {
                        Start-Service -Name PH_V002_RFC_PRD
                        Sleep 2
                        Set-Service -Name PH_V002_RFC_PRD -StartupType Automatic
                    }
                    else
                    {
                        Start-Service -Name PH_V002_RFC_PRD
                    }
                }
                elseif ($threeSTART -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           } '4' {
                cls
                $fourSTART = Read-Host 'Are you sure you want to START Environment? (Y/N)'
                if ($fourSTAT -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to START Production Environment"
                    Sleep 3
                    Write-Host "Setting Service into Automatic Startup Type"
                    Set-Service -name Hamachi2Svc -StartupType Automatic
                    Sleep 2
                    start-service -name Hamachi2Svc
                    Sleep 2
                }
                elseif ($fourSTART -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           }'q' {
                return
           }   
           #({[string]$start -ne 'q' -or '1' -or '2' -or '3' -or '4' -or '5'})
              #  {
             #  Write-Host
             #  Write-Host "You have typed wrong letter - going back to menu." 
              # Write-Host "Please choose option 1/2/3/4/5 or quit(q)"
              # Sleep 6
              #  }
     }
}
until ($input -eq 'q')
}

Function Restart-Type
{
do
{
     Restart-Menu
     $restart = Read-Host "Please select which Spool Services you want to RESTART: "
     switch ($restart)
     #Asking user to select Spool Service to RESTART
     #That function doesn't have option changing Startup Type
     #If user will answer with other option than 1/2/3/4/5 or quit(q) then he will back to the menu
     {
           '1' {
                cls
                $oneRESTART = Read-Host 'Are you sure you want to RESTART MBP - HS_I-Imaging_RFC_PRD? (Y/N)'
                if ($oneRESTART -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to RESTART MBP - HS_I-Imaging_RFC_PRD..."
                    Sleep 5
                    Restart-Service -name HS_I-Imaging_RFC_PRD
                    Sleep 2
                }
                elseif ($oneRESTART -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }


           } '2' {
                cls
                $twoRESTART = Read-Host 'Are you sure you want to RESTART MP1 - HS_RFC_PRD? (Y/N)'
                if ($twoRESTART -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to RESTART MP1 - HS_RFC_PRD..."
                    Sleep 5
                    Restart-Service -name HS_RFC_PRD
                    Sleep 2
                }
                elseif ($twoRESTART -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           } '3' {
                cls
                $threeRESTART = Read-Host 'Are you sure you want to RESTART WPP - PH_RFC_PRD + PH_V002_RFC_PRD? (Y/N)'
                if ($threeRESTART -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to RESTART WPP - PH_RFC_PRD + PH_V002_RFC_PRD..."
                    Sleep 5
                    Restart-Service -name PH_RFC_PRD
                    Restart-Service -name PH_V002_RFC_PRD
                    Sleep 2
                }
                elseif ($threeRESTART -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           } '4' {
                cls
                $sixRESTART = Read-Host 'Are you sure you want to RESTART Environment? (Y/N)'
                if ($sixRESTART -eq 'y')
                {
                    Sleep 2
                    Write-Host "Preparing to RESTART Production Environment"
                    Sleep 3
                    Write-Host "Setting Service into Manual Startup Type"
                    Set-Service -name Hamachi2Svc -StartupType Manual
                    Sleep 2
                    stop-service -name Hamachi2Svc
                    Sleep 2
                }
                elseif ($sixRESTART -eq 'n')
                {
                    Write-Host "Going back to menu."
                    Sleep 2
                }
                else
                {
                    Write-Host "You have typed wrong letter - going back to menu."
                    Sleep 2
                }
           }'q' {
                return
           }
             ## ({[string]$restart -ne '1' -or '2' -or '3' -or '4' -or '5' -or 'q'})
              #  {
             #  Write-Host
             #  Write-Host "You have typed wrong letter - going back to menu." 
             #  Write-Host "Please choose option 1/2/3/4/5 or quit(q)"
             #  Sleep 6
             #   }
     }
}
until ($input -eq 'q')
}

do
{
     Menu
     $input = Read-Host "Please select what to do with Spool Services "
     switch ($input)
     #Loop, to let user choose what to do with spool services
     {
           '1' {
                cls
                Stop-Type
           } '2' {
                cls
                Start-Type
           } '3' {
                cls
                Restart-Type
           }'q' {
                return
           } 
           
           #([string]$input -ne '1' -or '2' -or '3' -or 'q'})
            #    {
             #  Write-Host
              # Write-Host "You have typed wrong letter - going back to menu." 
               #Write-Host "Please choose option 1/2/3 or quit(q)"
               #Sleep 6 } 
           }
           
     
}
until ($input -eq 'q')