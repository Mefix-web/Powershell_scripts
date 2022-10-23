Import-Module -Name VMWare.PowerCLI

$CredsFile = "Path to txt file"
Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File $CredsFile