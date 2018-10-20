
<#
.ScriptName:  AddComputerDescription.ps1

.Description: Add computer name and it will update that computer description in AD
              with Vendor | Name | ID Number

.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
 
#>



Clear-host
$block = @"
          _           _                   
         (_)         | |                  
__      ___ _ __   __| | _____      _____ 
\ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / / __|
 \ V  V /| | | | | (_| | (_) \ V  V /\__ \
  \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/ |___/
   -- Updating Computer Description --                                       
                                          
"@

Write-Host 
Write-Host $block -ForegroundColor red

Import-Module ActiveDirectory
$Computer = Read-Host => [ Enter Computer Name ]

Write-Host
$vendor = (Get-WMIObject -ComputerName $Computer Win32_ComputerSystemProduct).Vendor
$name   = (Get-WMIObject -ComputerName $Computer Win32_ComputerSystemProduct).Name
$IdentifyingNumber = (Get-WMIObject -ComputerName $Computer Win32_ComputerSystemProduct).identifyingNumber

Write-Host
$vendor
$name
$identifyingNumber

Set-ADComputer $Computer -Description "$vendor : $name : $IdentifyingNumber"
