<#
.ScriptName: AddGroupMembers.ps1

.Description: Import users from CSV file and add them into specific AD Group

.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
 
#>


# START OF SCRIPT
$CurrentUserName = $env:UserName
$ScriptProcessStartTime = Get-Date
write-output “” `r
write-output “Script initialized by $CurrentUserName and started processing at $ScriptProcessStartTime `r ”
$ScriptTimer = [System.Diagnostics.Stopwatch]::StartNew()
write-output “” `r

## SCRIPT BODY

Import-module ActiveDirectory

#
# Add memmbers / users "SamAcountNames" into the UserList.csv file 
# 
$List = Import-CSV -Path "C:\PS\UserList.csv"
$Group = Read-Host [Enter Name of Group] 

#Loop through user in the CSV

ForEach ($User in $List)

{
Add-ADGroupMember -Identity $Group  -Member $User.username
}  -verbose

Write-Host [ Import of users into $Group Completed ] - foregroundcolor white -BackgroundColor Red




Write-Host

## END OF SCRIPT
$ScriptProcessEndTime = Get-Date
write-output “Script started processing at $ScriptProcessStartTime and completed at $ScriptProcessEndTime.” `r
write-host “Total Processing Time: $($ScriptTimer.Elapsed.ToString())”