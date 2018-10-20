<#
.ScriptName:  UserDidNotLogIn30days.ps1

.Description: Add computer name and it will update that computer description in AD
              with Vendor | Name | ID Number

.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
 
#>




$days = 30
$createdtime = (Get-Date).Adddays(-($days))
Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true) -and (whencreated -lt $createdtime)} | 
Select-Object Name,DistinguishedName

<# Create a CSV file with user who did not login for last 30 days #>

$createdtime = (Get-Date).Adddays(-(30))
Get-ADUser -Filter {(lastlogontimestamp -notlike "*") -and (enabled -eq $true) -and (whencreated -lt $createdtime)} | 
Select Name,DistinguishedName | Export-CSV -Path "C:\PS\30DayUsers.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Users that did not login for last 30 days - check report => C:\PS\30DayUsers.csv" -backgroundcolor green -foregroundcolor yellow

