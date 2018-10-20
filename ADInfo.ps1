
<#
.ScriptName:  ADinfo.ps1

.Description: Simple Menu driven script for simple Admin tasks

.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
 
#>

Clear-host
 $block = @"

              ___
             /   \    's true!
  /'8-8'\    |- _|     /
 (    ._)   ) O O ( 
     ( |\    | _ |
     (_/')   \ -'/
      \_'===/|\_/|\===
    /`-'/. /.\___/.\  \
   /   //   /.\ /.\   ;\_____________
   `__''|     | |     | \

       I'm Watching you !

"@

Write-Host 
Write-Host $block -ForegroundColor Green

Import-Module ActiveDirectory


function Show-Menu
{
     param (
           [string]$Title = 'ACTIVE DIRECTORY INFO'
     )
     Write-Host "================ $Title ================" -ForegroundColor white -BackgroundColor red
     Write-Host
     Write-Host "1: List Domain Controllers in Domain"
     Write-Host "2: List FSMO Roles holders and Schema version"
     Write-Host "3: Check AD Replication."
     Write-Host "Q: Press 'Q' to quit."
}

do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                cls
                Write-Host
                Write-Host ":You have these DC servers in Domain:" -ForegroundColor red -BackgroundColor yellow
                Get-ADDomainController -filter * | Select-Object name
           } '2' {
                cls
                Write-Host
                Write-Host ":FSMO Roles Holders and Schema version:" -ForegroundColor red -BackgroundColor yellow
                netdom query fsmo 
                Write-Host
                Get-ADObject(Get-ADRootDSE).schemaNamingContext -Properties objectVersion
           } '3' {
                cls
                Write-Host
                Write-Host ":Here is Result of AD Replication:" -ForegroundColor red -BackgroundColor yellow
                repadmin /replsum /bysrc /bydest /errorsonly
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')