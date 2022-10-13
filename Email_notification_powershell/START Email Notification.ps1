[CmdletBinding()]
Param( 
[Parameter(Mandatory=$False)][string]$emailsend
)

# EMAIL PROPERTIES 
 # Set the recipients of the report. 
  $User = "<Email Here>"
  $CC1 = "<Email CC here>"
    $smtpServer = "SMTP server" 
    $titleDate = get-date -uformat "%m-%d-%Y - %A" 

#Complete menu to Send STOP Email
Write-Host "1: Select number 1 to send DEV Patching Email."
Write-Host "2: Select number 2 to send TST Patching Email."
Write-Host "3: Select number 3 to send ACC Patching Email."
Write-Host "4: Select number 4 to send PRD Patching Email."
Write-Host "Q: Press 'Q' to quit."

$emailsend = Read-Host "Please select environment"
    if($emailsend -eq 1)
    {
        Write-Host "Sending Email notification to $user and to $CC1" 
   

  $smtp = New-Object Net.Mail.SmtpClient($smtpServer) 
  $msg = New-Object Net.Mail.MailMessage 
  $msg.To.Add($user) 
  $msg.CC.Add($CC1)
        $msg.From = "Email_From_who" 
  $msg.Subject = "[DEV] Agile Microsoft Windows Patching" 
        $msg.IsBodyHTML = $true
        $msg.Body = "Hello Team,<br /><br />Please be informed that <b>DEV</b> Agile is no longer under the maintenance.<br />In About 30 minutes, Agile <b>DEV</b> will be available again.<br />Please resume monitoring the Agile <b>DEV</b> environment.<br /><br /> With Kind Regards<br /> <i>ECM Team</i>"
  $smtp.Send($msg) 
        $body = "" 
    }
    elseif($emailsend -eq 2)
    {
        Write-Host "Sending Email notification to $user and to $CC1" 
   

  $smtp = New-Object Net.Mail.SmtpClient($smtpServer) 
  $msg = New-Object Net.Mail.MailMessage 
  $msg.To.Add($user) 
  $msg.CC.Add($CC1)
        $msg.From = "Email_From_who" 
  $msg.Subject = "[TST] Agile Microsoft Windows Patching" 
        $msg.IsBodyHTML = $true
        $msg.Body = "Hello Team,<br /><br />Please be informed that <b>TST</b> Agile is no longer under the maintenance.<br />In About 30 minutes, Agile <b>TST</b> will be available again.<br />Please resume monitoring the Agile <b>TST</b> environment.<br /><br /> With Kind Regards<br /> <i>ECM Team</i>"
  $smtp.Send($msg) 
        $body = "" 
    }
    elseif($emailsend -eq 3)
    {
        Write-Host "Sending Email notification to $user and to $CC1" 
   

  $smtp = New-Object Net.Mail.SmtpClient($smtpServer) 
  $msg = New-Object Net.Mail.MailMessage 
  $msg.To.Add($user) 
  $msg.CC.Add($CC1)
        $msg.From = "Email_From_who" 
  $msg.Subject = "[ACC] Agile Microsoft Windows Patching" 
        $msg.IsBodyHTML = $true
        $msg.Body = "Hello Team,<br /><br />Please be informed that <b>ACC</b> Agile is no longer under the maintenance.<br />In About 30 minutes, Agile <b>ACC</b> will be available again.<br />Please resume monitoring the Agile <b>ACC</b> environment.<br /><br /> With Kind Regards<br /> <i>ECM Team</i>"
  $smtp.Send($msg) 
        $body = "" 
    }
    elseif($emailsend -eq 4)
    {
        Write-Host "Sending Email notification to $user and to $CC1" 
   

  $smtp = New-Object Net.Mail.SmtpClient($smtpServer) 
  $msg = New-Object Net.Mail.MailMessage 
  $msg.To.Add($user) 
  $msg.CC.Add($CC1)
        $msg.From = "Email_From_who" 
  $msg.Subject = "[PRD] Agile Microsoft Windows Patching" 
        $msg.IsBodyHTML = $true
        $msg.Body = "Hello Team,<br /><br />Please be informed that <b>PRD</b> Agile is no longer under the maintenance.<br />In About 30 minutes, Agile <b>PRD</b> will be available again.<br />Please resume monitoring the Agile <b>PRD</b> environment.<br /><br /> With Kind Regards<br /> <i>ECM Team</i>"
  $smtp.Send($msg) 
        $body = "" 
    }
    elseif($emailsend -eq 'q')
    {
        return
    }