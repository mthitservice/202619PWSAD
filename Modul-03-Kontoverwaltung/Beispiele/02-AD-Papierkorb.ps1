<#
.SYNOPSIS
    Trainer-Demo: AD-Papierkorb aktivieren und Wiederherstellung zeigen.
#>

Import-Module ActiveDirectory

# 1. Aktivieren (einmalig, nicht reversibel)
$forest = (Get-ADForest).RootDomain
$feature = Get-ADOptionalFeature -Filter "Name -eq 'Recycle Bin Feature'"

if (-not $feature.EnabledScopes) {
    Enable-ADOptionalFeature -Identity 'Recycle Bin Feature' `
        -Scope ForestOrConfigurationSet -Target $forest -Confirm:$false
    Write-Host 'AD-Papierkorb aktiviert.' -ForegroundColor Green
} else {
    Write-Host 'AD-Papierkorb ist bereits aktiv.' -ForegroundColor Cyan
}

# 2. Test: User anlegen, löschen, wiederherstellen
$ouUsers = "OU=Benutzer,OU=PWSAD,$((Get-ADDomain).DistinguishedName)"
$pwd = ConvertTo-SecureString 'Pa55w.rd2619' -AsPlainText -Force

New-ADUser -Name 'recycle.test' -SamAccountName 'recycle.test' `
    -UserPrincipalName 'recycle.test@ITH-01.local' `
    -Path $ouUsers -AccountPassword $pwd -Enabled $true

Remove-ADUser -Identity 'recycle.test' -Confirm:$false

# 3. Gelöschte Objekte anzeigen
Get-ADObject -Filter 'isDeleted -eq $true -and Name -like "*recycle.test*"' `
    -IncludeDeletedObjects -Properties * |
    Select-Object Name, LastKnownParent, ObjectClass

# 4. Wiederherstellen
Get-ADObject -Filter 'isDeleted -eq $true -and SamAccountName -eq "recycle.test"' `
    -IncludeDeletedObjects |
    Restore-ADObject

Get-ADUser -Identity 'recycle.test'
