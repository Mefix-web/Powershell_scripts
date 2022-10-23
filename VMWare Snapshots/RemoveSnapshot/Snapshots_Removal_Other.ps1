Import-Module -Name VMWare.PowerCLI

# Connecting to Vcenter
$PasswordFile = "PATH\Password.txt"
$SecurePassword = Get-Content $PasswordFile | ConvertTo-SecureString
$Credentials = New-Object System.Management.Automation.PSCredential ("Username_to_VIServer",$SecurePassword)
Connect-VIServer -Server FQDN server name -Credential $Credentials

# Removing Snapshots
# Firstly I am importing server names from csv files so they don't have to be static set in script
Import-Csv -Path PATH\Servers.csv |
    ForEach-Object -Process { Get-VM -Name $_.Other |
    Get-Snapshot | where {$_.name -like "Patching Other*"} |
    Remove-Snapshot -Confirm:$false }

Disconnect-VIServer -Server FQDN server name -Confirm:$false