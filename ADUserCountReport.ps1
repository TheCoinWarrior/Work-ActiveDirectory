<#

.ScriptName ADUserCountReport.ps1

.DESCRIPTION AD User Count: Total, Enabled vs Disabled, and also create html file



.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
 
#>


Clear-host

$block = @"
 
                          ___
                       .-"-~-"-.
                      /.-"-.-"-.\
                      ||((o|o))||
                      )\__/V\__/(
                     / ~ -...- ~ \
                    |\` ~. ~ .~ `/|
                 () | `~ - ^ - ~` |
             () //  | ;  '  :  .  |
            ()\\/_() \ . : '  ; '/
           ___/ /_____'.   ; ' .'____
                 _   ^ `uu---uu`    /\
          __jgs________^ _________^_\/
                       \ \
                       //\\()
                     ()/  ()
                      ()

 
"@
 
Write-Host $block -ForegroundColor Green


Write-Host
Write-Host ACTIVE DIRECTORY USER COUNT -ForegroundColor white -BackgroundColor red
Write-Host Users in AD including Disabled users: (Get-ADUser -filter *).count

Write-Host
Write-Host ENABLED vs. DISABLED -ForegroundColor White -BackgroundColor Red
Write-Host ENABLED : (Get-AdUser -filter * |Where {$_.enabled -eq "True"}).count
Write-Host DISABLED: (Get-ADUser -filter * |Where {$_.enabled -ne "False"}).count

$TotalAccounts = (Get-ADUser -filter *).count
$EnabledUsers = (Get-AdUser -filter * |Where {$_.enabled -eq "True"}).count
$DisabledUsers = (Get-ADUser -filter * |Where {$_.enabled -ne "False"}).count

#export to HTML Report
$html ="
<html>
    <header>
        <style>
            table {
                border-collapse: collapse;
            }
            td, th {
                border: 1px solid black;
            }
        </style>
    </header>
    <body>
    <br><br>
        <table>
        <tr>
            <td>Total Number of All user accounts in Active Directory</td>
            <td>$TotalAccounts</td>
        </tr>
        <tr>
            <td>Total Number of Enabled Users in Active Directory</td>
            <td>$EnabledUsers</td>
        </tr>
        <tr>
            <td>TotalNumber of Disabled Userrs in Active Directory</td>
            <td>$DisabledUsers</td>
        </tr>
        </table>
    </body>
</html>"

$html | Out-File "TotalUsersADReport.html"

Write-host
Write-host => Report TotalUsersADReport.html has been created ! .... -f yellow