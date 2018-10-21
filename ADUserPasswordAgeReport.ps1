<#
.ScriptName: ADUSerPasswordAgeReport.ps1

.Description 
    Create CSV file with all users in AD and report on Password age for individual user
    This is a good report for auditing purposes.

.NOTES
LICENSE MIT
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>


# Import the Active Directory module if not already loaded

Import-Module ActiveDirectory -ErrorAction Stop


# Save the report with PasswordAge for users in Active Directory
$default_log = $env:userprofile + '\Documents\user_password_age.csv'
 
# Enumerate all the domain in a forest
foreach($domain in (get-adforest).domains){
    #query all users except critical system objects
    get-aduser -LDAPFilter "(!(IsCriticalSystemObject=TRUE))" `
    -properties enabled,whencreated,whenchanged,lastlogontimestamp,PwdLastSet,PasswordExpired,DistinguishedName,servicePrincipalName `
    -server $domain |`
    select @{name='Domain';expression={$domain}},`
    SamAccountName,enabled,PasswordExpired,`
    @{Name="PwdLastSet";Expression={[datetime]::FromFileTime($_.PwdLastSet)}}, `
    @{Name="PwdAge";Expression={if($_.PwdLastSet -ne 0){(new-TimeSpan([datetime]::FromFileTimeUTC($_.PwdLastSet)) $(Get-Date)).days}else{0}}}, `
    @{Name="LastLogonTimeStamp";Expression={[datetime]::FromFileTime($_.LastLogonTimeStamp)}}, `
    whenchanged,whencreated,
    @{Name="HasServicePrincipal";Expression={if($_.servicePrincipalName){$True}else{$False}}}, `
    distinguishedname | export-csv $default_log -NoTypeInformation
}