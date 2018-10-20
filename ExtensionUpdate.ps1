

<#
.ScriptName:  ExtensionUpdate.ps1

.Description: Update Phone Extension in AD for individual user
              example: update user john.doe with extension 6666

.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
#>

cls
Import-module ActiveDirectory
write-host
Write-host ... Provide UserName and Extension .. -ForegroundColor white -BackgroundColor Red
Write-host _______________________________________
Write-Host
$user = Read-Host => Enter UserName 
$extension = Read-Host => Enter Extension 

Set-ADUser -Identity $user -replace @{'ipPhone' = $($extension)}

write-host
write-host => $user updated with phone extension $extension -ForegroundColor green
Write-host
write-host  "Review the change" -ForegroundColor yellow 
Get-ADuser -identity $user -Properties ipPhone

Write-host -nonewline " Continue ? [Y/N] : " -ForegroundColor white -BackgroundColor red
$reponse = read-host
if ($reponse -ne "Y") {exit}
else { .\ExtensionUpdate.ps1 }

