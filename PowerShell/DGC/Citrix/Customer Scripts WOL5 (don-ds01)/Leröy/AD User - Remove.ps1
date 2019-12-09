$UserPrincipalName = "test.testsson@leroy.se"



$ReturnValue = $null
if (!(Get-Module | where {$_.Name -match "ActiveDirectory"})) { Import-Module ActiveDirectory }
if (!(Get-PSSnapin | where {$_.Name -match "Exchange.Management"})) { Add-PSSnapin Microsoft.Exchange.Management.* }

$ADUser = Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}

if ($ADUser)
{
if ([ADSI]::Exists("LDAP://CN=ExchangeActiveSyncDevices,$($ADUser.DistinguishedName)") -eq $True)
{
$ErrorActionPreference = "Stop"
Remove-ADObject "CN=ExchangeActiveSyncDevices,$($ADUser.DistinguishedName)" -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until ([ADSI]::Exists("LDAP://CN=ExchangeActiveSyncDevices,$($ADUser.DistinguishedName)") -eq $False -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of LDAP container 'ExchangeActiveSyncDevices' for $UserPrincipalName."
return
}
}


$ErrorActionPreference = "Stop"
Remove-ADUser $ADUser -Confirm:$False -ErrorVariable ReturnValue

$Timeout = 120
do
{
sleep 1
$Timeout = $Timeout - 1
}
until (!(Get-ADUser -Filter {UserPrincipalName -eq $UserPrincipalName}) -or $Timeout -le 0)

if ($Timeout -le 0)
{
$ReturnValue = "Timeout expired during deletion of ADUser $UserPrincipalName."
return
}
}
else
{
$ReturnValue = "AD account not found"
return
}