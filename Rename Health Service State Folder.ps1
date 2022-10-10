###################################################################
#
# Title: Rename Health Service State Folder.ps1
# Author: Tom Ziegler
# Company: Microsoft
# Last Modified: 10-1-2022
# Version: 1.0
#
# Description - # Renames the Healther Service State Folder
###################################################################

# Get Credentials
$Username = 'DOMAIN\USER'
$Password = 'PASSWORDFORABOVEACCOUNT' | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential($Username,$Password)


# Enter PSSessions
$S1 = New-PSsession  -ComputerName SERVERNAME -Credential $Credentials
$SB = {

# Renames Health Service State Folder
    Rename-Item -Path "\\SERVERNAME\c`$\Program Files\Microsoft Monitoring Agent\Agent\Health Service State" -NewName 'Health Service State.old'
}

Invoke-Command -Session $s1 -ScriptBlock $SB
Remove-PSSession $S1
