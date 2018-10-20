
<#
.ScriptName:  User2User.ps1

.Description: Copying Group Membership from one user to another
              Enter source user and Destination user
              All Groups memebrhip will be copied over to Destination user
.NOTES 
    THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED  
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR  
    FITNESS FOR A PARTICULAR PURPOSE. 
 
#>





import-module ActiveDirectory
   cls 
   write-host "###########################################"
   write-host "| Copy Group Membership from USER to USER |" -ForegroundColor white -BackgroundColor red
   write-host "###########################################"
   write-output " " 
   write-output " " 

   $SName = Read-Host => "Enter the source username " 
   $DName = Read-Host => "Enter the username you want to modify " 
     
   $G = Get-ADUser -Identity $SName -Properties memberOf

   foreach($group in $G.memberof) 
    
  {  
  Add-ADGroupMember -Identity $group -Member $DName 
   
  write-output $group 
  }


Write-host -nonewline " Continue ? [Y/N] : " -ForegroundColor white -BackgroundColor red
$reponse = read-host
if ($reponse -ne "Y") {exit}
else { .\User2User.ps1 }
