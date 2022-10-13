[CmdletBinding()]
Param( 
[Parameter(Mandatory=$False)][string]$start
)

#arrays for startup type of service
$StartupfileMP1 = 'PATH_TO_MP1'
$StartupfileMBP = 'PATH_TO_MBP'
$StartupfileWPP = 'PATH_TO_WPP'


#Complete menu to STOP Spool Services
cls
Write-Host "================(SAP Name)-(Service Name)================" 
Write-Host "1: Select number 1 to START MBP - HS_I-Imaging."
Write-Host "2: Select number 2 to START MP1 - HS_PRD."
Write-Host "3: Select number 3 to START WPP - PH + PH_PHV2."
Write-Host "Q: Press 'Q' to quit."
#Loop for automatic work of script, checking what has been choose from bat file.
    if ($start -eq 1)
    {
                    Sleep 2
                    Write-Host "Preparing to START MBP - HS_I-Imaging_RFC_PRD..."
                    Write-Host "Checking service Startup Type of MBP Spool Services"
                    #Setting content from StartupFile of every SAP service StartUp
                    $ContentMBP = Get-Content -Path $StartupfileMBP
                    Sleep 3
                    #checking what was the startup type before the STOP
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
    elseif($start -eq 2)
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
    elseif($start -eq 3)
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
    elseif($stop -eq 'q')
    {
        return
    }