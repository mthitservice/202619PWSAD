<#
.SYNOPSIS
    Trainer-Demo: Einen Benutzer mit allen wichtigen Eigenschaften anlegen.

.DESCRIPTION
    Zeigt die wichtigsten Parameter von New-ADUser und den Unterschied
    zwischen SamAccountName, UPN und DisplayName.
#>

Import-Module ActiveDirectory

$ouUsers = "OU=Benutzer,OU=PWSAD,$((Get-ADDomain).DistinguishedName)"
$pwd     = ConvertTo-SecureString 'Pa55w.rd2619' -AsPlainText -Force

$params = @{
    Name              = 'Max Mustermann'
    GivenName         = 'Max'
    Surname           = 'Mustermann'
    SamAccountName    = 'm.mustermann'
    UserPrincipalName = 'm.mustermann@ITH-01.local'
    DisplayName       = 'Mustermann, Max'
    Path              = $ouUsers
    AccountPassword   = $pwd
    Enabled           = $true
    ChangePasswordAtLogon = $true
    Department        = 'IT'
    Title             = 'Administrator'
    Office            = 'Dresden'
}

New-ADUser @params

Get-ADUser -Identity 'm.mustermann' -Properties Department,Title,Office |
    Format-List Name, SamAccountName, UserPrincipalName, Department, Title, Office, Enabled
