[CmdletBinding()]
Param( 
[Parameter(Mandatory=$False)][string]$stop
)

#arrays for startup type of service
$StartupfileMP1 = 'PATH_TO_MP1'
$StartupfileMBP = 'PATH_TO_MBP'
$StartupfileWPP = 'PATH_TO_WPP'


#Complete menu to STOP Spool Services
cls
Write-Host "================(SAP Name)-(Service Name)================" 
Write-Host "1: Select number 1 to STOP MBP - HS_I-Imaging."
Write-Host "2: Select number 2 to STOP MP1 - HS_PRD."
Write-Host "3: Select number 3 to STOP WPP - PH + PH_PHV2."
Write-Host "Q: Press 'Q' to quit."
#Loop for automatic work of script, checking what has been choose from bat file.
     if ($stop -eq 1)
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
                    #checking what was the startup type before the STOP
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
     elseif($stop -eq 2)
     {
                    cls
                    Sleep 2
                    Write-Host "Preparing to stop MP1 - HS_RFC_PRD..."
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
     elseif($stop -eq 3)
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
     elseif($stop -eq 'q')
     {
        return
     }
