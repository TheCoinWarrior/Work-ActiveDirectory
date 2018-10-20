

<#
.ScriptName: Update-EmployeeID.ps1
.Description: Updates individual user in AD with EmployeeID

.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
 
#>

Clear-host
 $block = @"
                 .-.                             .-.                   
     __&__
  /     \
 |       |
 |  (o)(o)
 C   ,---_)
  | |,___|   "I am Homer of the Borg.  You will be assimilated.  Resistance
  |  \__/     is irrelevant.  Preparation is irrel...MMMmmm...doughnut!"
  /_____\
 /_____/ \  

  https://www.incredibleart.org/links/ascii/funnies.html

"@

Write-Host 
Write-Host $block -ForegroundColor Green

 
Import-Module ActiveDirectory
Write-Host " Update EmployeeID Attribute " -ForegroundColor white -BackgroundColor red

Write-Host
$user = Read-Host " Enter User Name "
$EmployeeID = Read-Host " Enter EmployeeID for User "

Set-ADUSer -identity $user -EmployeeID $EmployeeID 
Get-ADUser -identity $user -Properties * | Select-Object SamAccountName,EmployeeID

Write-host "[ Completed ]" -ForegroundColor white -BackgroundColor Red

Write-Host 
Write-Host "----------------------------------------------------"
# Run again or Exit

write-host -nonewline "Continue? (Y/N) "
$response = read-host
if ( $repsonse -eq "N") { exit }
if ( $response -eq "Y" ) { .\Update-EmployeeID.ps1 }


