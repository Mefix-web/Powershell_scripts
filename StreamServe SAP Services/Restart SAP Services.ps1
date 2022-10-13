[CmdletBinding()]
Param( 
[Parameter(Mandatory=$False)][string]$restart
)


#Complete menu to STOP Spool Services
cls
Write-Host "================(SAP Name)-(Service Name)================" 
Write-Host "1: Select number 1 to RESTART MBP - HS_I-Imaging."
Write-Host "2: Select number 2 to RESTART MP1 - HS_PRD."
Write-Host "3: Select number 3 to RESTART WPP - PH + PH_PHV2."
Write-Host "Q: Press 'Q' to quit."
    if($restart -eq 1)
    {
                    Sleep 2
                    Write-Host "Preparing to RESTART MBP - HS_I-Imaging_RFC_PRD..."
                    Sleep 5
                    Restart-Service -name HS_I-Imaging_RFC_PRD
                    Sleep 2
    }
    elseif($restart -eq 2)
    {
                    Sleep 2
                    Write-Host "Preparing to RESTART MP1 - HS_RFC_PRD..."
                    Sleep 5
                    Restart-Service -name HS_RFC_PRD
                    Sleep 2
    }
    elseif($restart -eq 3)
    {
                    Sleep 2
                    Write-Host "Preparing to RESTART WPP - PH_RFC_PRD + PH_V002_RFC_PRD..."
                    Sleep 5
                    Restart-Service -name PH_RFC_PRD
                    Restart-Service -name PH_V002_RFC_PRD
                    Sleep 2
    }
    elseif($restart -eq 'q')
    {
        return
    }