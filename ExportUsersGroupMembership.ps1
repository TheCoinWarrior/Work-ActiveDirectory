<#

SCRIPT NAME : ExportUsersGroupMembership.ps1

.DESCRIPTION

  You want to export group membership of multiple groups into csv file. 
  It will create a csv file under c:\PS\report.csv wwhit all users and their
  Group memberships

.EXAMPLE

    .\ExportUsersGroupMembership.ps1

#>

# Import the Active Directory module if not already loaded

if (-not (Get-Module ActiveDirectory)){
    Import-Module ActiveDirectory -ErrorAction Stop
}

# Import the file with list of all groups in AD

Get-ADUser -Filter * -Properties DisplayName,memberof | % {
  New-Object PSObject -Property @{
  UserName = $_.DisplayName
  Groups = ($_.memberof | Get-ADGroup | Select -ExpandProperty Name) -join ","
  }
} | Select UserName,Groups | Export-Csv C:\ps\report.csv -NTI 

