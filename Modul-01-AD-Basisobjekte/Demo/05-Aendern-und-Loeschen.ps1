<#
.SYNOPSIS
    Trainer-Demo: Objekte ändern und sicher löschen.
#>

Import-Module ActiveDirectory

# 1. Eigenschaft ändern
Set-ADUser -Identity 'm.mustermann' -Title 'Senior Administrator' -Office 'Dresden HQ'

# 2. Mehrere User per Pipeline
Get-ADUser -Filter "Department -eq 'IT'" -SearchBase "OU=Benutzer,OU=PWSAD,$((Get-ADDomain).DistinguishedName)" |
    Set-ADUser -Company 'ITH-01 GmbH'

# 3. OU löschen – Schutz vorher entfernen
$dn = "OU=Deaktiviert,OU=PWSAD,$((Get-ADDomain).DistinguishedName)"
Set-ADOrganizationalUnit -Identity $dn -ProtectedFromAccidentalDeletion $false
Remove-ADOrganizationalUnit -Identity $dn -Recursive -Confirm:$false

# 4. User löschen
Remove-ADUser -Identity 'm.mustermann' -Confirm:$false
