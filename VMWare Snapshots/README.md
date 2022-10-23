For security reasons I've removed all sensitive data from scripts and replaced them with defaul values.

Purpose of those scripts:
CreateSnapshot - this script is mostly used with task scheduler before patching. It will create a snapshots for every server declared in table of file Servers.csv. Next, script will send a report via smtp to declared user with attachment of selected snapshots on declared servers.
RemoveSnapshot - this script is mostly used with task scheduler after patching. It is possible to schedule with X days delay after patching to remove snapshots that were created.

Script Encrypt Password.ps1
This script should be run once every time password for vmware has been changed. After running it once, it is not necessary to run it until change of the password.
This script will ask for a password and encrypt this to the file.

Directory Reports is a place for all generated reports.

.bat files in directory CreateSnapshot/RemoveSnapshot are only used for task scheduler with unrestricted policy. By this way it is easier to use them with task scheduler.