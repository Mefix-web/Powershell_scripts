Import-Module -Name VMWare.PowerCLI


# Report Properties
    $reportPath = "Path to reports directory";
    $reportName = "Snapshots_$(get-date -format ddMMyyyy).html";
    $Report = $reportPath + $reportName

# HTML formatting
$a = "<style>"
$a = $a + "BODY{background-color:white;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;foreground-color: black;background-color: LightBlue}"
$a = $a + "TD{border-width: 1px;padding: 5px;border-style: solid;border-color: black;foreground-color: black;background-color: white}"
$a = $a + "</style>"

# Connecting to Vcenter
$PasswordFile = "PATH\Password.txt"
$SecurePassword = Get-Content $PasswordFile | ConvertTo-SecureString
$Credentials = New-Object System.Management.Automation.PSCredential ("Username_to_VIServer",$SecurePassword)
Connect-VIServer -Server FQDN server name -Credential $Credentials

# Creating Snapshots
# Firstly I am importing server names from csv files so they don't have to be static set in script
Import-Csv -Path PATH\Servers.csv |
    ForEach-Object -Process { Get-VM -Name $_.Other |
    New-Snapshot -Name "Patching Other $(get-date -f dd-MM)" -Description $(Get-VM -Name $_.Other) }


# Checking if snapshots were created and creating report from it
Import-Csv -Path PATH\Servers.csv | Where-Object { $_.Other -ne ''} |
    ForEach-Object -Process { Get-VM -Name $_.Other | 
    Get-Snapshot | where {$_.name -like "Patching Other*"} |
    Select-Object  VM, Created, Name } |
    ConvertTo-Html -head $a -body "<H2>Snapshot Report</H2>" | Out-File $Report


Disconnect-VIServer -Server FQDN server name -Confirm:$false


# Email Properties
    $titleDate = get-date -uformat "%A %m-%d-%Y"
    $ToUser = "<User>"
    $FromUser = "<From>"
    $smtpServer = "SMTP"
    $Subject = "Snapshot Report $titleDate"
    $body = "Please find attached Snapshot Report"
    $attachment = $Report
    
# Email Sending
    $msg = New-Object System.Net.Mail.MailMessage
    $msg.from = $FromUser
    $msg.To.Add($ToUser)
    $msg.IsBodyHtml = $True
    $msg.Subject = $Subject
    $attach = New-Object Net.Mail.Attachment($attachment)
    $msg.Attachments.Add($attach)
    $msg.body = $body
    $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
    $smtp.Send($msg)