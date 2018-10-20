



<#
.ScriptName:  ADInstallInfo.ps1

.Description: Show FQDN for AD Domain, NetBIOS Domain Name and when AD was installed

.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
 
#>



Clear-host
$block = @"

                      |
                     _=_
                     \ /.           _=
        .-.    _ .-_ |  |_         |  |
 "   _  | |   | ||  \|    |_.--.   |  |
 |  | |_| |-__| ||          |  |,-.|  |-_   __
|H|-|   '                          |     | |  |
                                         |_|  |Na
------------- VANCOUVER -------------------------

"@

Write-Host 
Write-Host $block -ForegroundColor red


Write-Host "Active Directory Creation information" -BackgroundColor red -ForegroundColor white
Write-Host "-------------------------------------"
Write-Host 
write-output "Checking Active Directory Creation Date... " `r 
write-output "Displaying AD partition creation information... " `r

Import-Module ActiveDirectory
Get-ADObject -SearchBase (Get-ADForest).PartitionsContainer -LDAPFilter "(&(objectClass=crossRef)(systemFlags=3))" -Property dnsRoot,NetBIOSName,whenCreated | Sort-Object whenCreated | Format-Table dnsRoot,nETBIOSName,whenCreated -AutoSize