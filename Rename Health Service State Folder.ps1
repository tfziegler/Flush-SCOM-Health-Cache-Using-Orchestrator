###################################################################
#
# Title: Rename Health Service State Folder.ps1
# Author: Tom Ziegler
# Company: Microsoft
# Last Modified: 10-11-2022
# Version: 1.1
#
# Version History:
# 1.0 - Original
# 1.1 - Added Check for existing Health Service State.old folder and delete it if it exists.
#
# Description - # Renames the Health Service State Folder
# THIS SCRIPT IS PROVIDED AS-IS WITH NO WARRANTY EITHER EXPRESSED OR IMPLIED
###################################################################

# Get Credentials
$Username = 'DOMAIN\USER'
$Password = 'PASSWORDFORABOVEACCOUNT' | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username,$Password)


# Enter PSSessions
$S1 = New-PSsession  -ComputerName SERVERNAME -Credential $Credentials
$SB = {

# Check if Foldername Exists
$FolderName = "\\SERVERNAME\c`$\Program Files\Microsoft Monitoring Agent\Agent\Health Service State.old"
if (Test-Path $FolderName) {
 
    Write-Host "Folder Exists"
    Remove-Item $FolderName -Force -Recurse
}
else
{
    Write-Host "Folder Doesn't Exists"
}

# Renames Health Service State Folder
    Rename-Item -Path "\\SERVERNAME\c`$\Program Files\Microsoft Monitoring Agent\Agent\Health Service State" -NewName 'Health Service State.old'
}

Invoke-Command -Session $s1 -ScriptBlock $SB
Remove-PSSession $S1
