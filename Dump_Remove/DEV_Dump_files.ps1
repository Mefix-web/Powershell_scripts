### Script has been written to clean up DUMP Files that are older than 30 days
### 
### Copyrights: Radoslaw Zudzin

#Setting if parameter is a mandatory
[CmdletBinding()]
Param( 
[Parameter(Mandatory=$False)][string]$menuy
)

#Setting  the path from where program will find DUMP files
$Fileset = @(Get-ChildItem -path Path_of_files_to_be_deleted -Include *.dmp, *.hdmp, *.mdmp -Recurse)
#Setting the date of the files
$old = [string](Get-Date).AddDays(-30)
#Define the path of the log file
$LogFile = "Path_of_log_file"
#Define the path of the log file for Deleted Dump Files
$DeleteLogFile = "Path_to_delete_log_file"
#Clearing the Logfiles to let script overwrite logfile
Clear-Content "Remove Delete_log_file"

#function of user menu
function menu
{

    cls
    $whoami = whoami
    Write-Host ""
    Write-Host "====== Hello $whoami ======" 
    Write-Host ""
    Write-Host "Welcome to cleaning DUMP files script" 
    Write-Host "Are you sure you want to clean up DUMP Files from the path Path_of_files_to_be_deleted" 
    Write-Host ""
} 
#Setting a function for automatic daily email notification
Function Mail
{
$Date = get-date

$From = "from@gmail.com"
$To = "to@gmail.com"
$Subject = "[DEV] Crash Dump Files Cleaning Script - $Date"
$Body = "Please be informed that crash dump files script has been executed."
$SMTPServer = "smtp_server"
$Attachment = $Logfile
Send-MailMessage -From $From -to $To -Subject $Subject -Body $Body -SmtpServer $SMTPServer -UseSsl -Attachments $Attachment
}
#If Bat file has parameter y
if ($menuy -eq 'y')
{
    Foreach ($File in $Fileset)
{
#If last file written is older than definition of $old then script deletes the files
    If ($File.LastWriteTime -lt $old)
{
        Remove-Item $File -Verbose
#Creating log information with the name of deleted file and date when file was deleted
        $Date = Get-Date
        $TextFile = $File.Fullname + " has been deleted on a date: " + $Date
        Add-Content -Path $Logfile -Value $Textfile -PassThru
#Creating log information with the name of deleted file and date when file was deleted
        $DeleteFile = $File.Fullname + " has been deleted on a date: " + $Date
        Add-Content -Path $DeleteLogFile -Value $DeleteFile -PassThru
 }
    Else 
{
#If last written is not older than definition of $old then script stops the program
#Creating log information when file is newer than range of $old
        $Textfile = $File.FullName + " is newer than deletion range of " + $old
        Add-Content -Path $Logfile -Value $Textfile -PassThru
}
}
mail
exit
}
#If batfile has parameter n
elseif ($menuy -eq 'n')
{
    Write-Host ""
    Write-Host "Parameter N has been choose. Stopping the program"
    sleep 3
    exit
}

 menu
#Asking user to choose between if he wants to Continue "Y" or he wants to Cancel "N"
$menu = Read-Host "Press 'Y' to continue and 'N' to cancel: "
if ($menu -eq 'y' -and $menuy -ne 'y' -and $menuy -ne 'n')
{
#Leaving first line empty to let script more likely clear to read
    Write-Host ""
    Write-Host "You pressed Y"
    Write-Host "Preparing to clean up Crash DUMP files"
    Sleep 2

    Foreach ($File in $Fileset)
{
#If last file written is older than definition of $old then script deletes the files
    If ($File.LastWriteTime -lt $old)
{
        Remove-Item $File -Verbose
#Creating log information with the name of deleted file and date when file was deleted
        $Date = Get-Date
        $TextFile = $File.Fullname + " has been deleted on a date: " + $Date
        Add-Content -Path $Logfile -Value $Textfile -PassThru
#Creating log information with the name of deleted file and date when file was deleted
        $DeleteFile = $File.Fullname + " has been deleted on a date: " + $Date
        Add-Content -Path $DeleteLogFile -Value $DeleteFile -PassThru
}
    Else 
{
#Leaving first line empty to let script more likely clear to read
#If last written is not older than definition of $old then script stops the program
#Creating log information when file is newer than range of $old
        Write-Host ""
        $Textfile = $File.FullName + " is newer than deletion range of " + $old
        Add-Content -Path $Logfile -Value $Textfile -PassThru

}
}
mail
exit
}
elseif ($menu -eq 'n' -and $menuy -ne 'y' -and $menuy -ne 'n')
{
#Leaving first line empty to let script more likely clear to read
    Write-Host ""
    Write-Host "You pressed N. Stopping the program"
}
else
{
#Leaving first line empty to let script more likely clear to read
#If user press anything else than "Y" and "N" the script will be stopped
    Write-Host ""
    Write-Host "You have pressed wrong letter. Stopping the program"
}

mail