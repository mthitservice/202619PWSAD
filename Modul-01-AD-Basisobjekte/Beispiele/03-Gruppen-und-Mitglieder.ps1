<#
.SYNOPSIS
    Trainer-Demo: Gruppen anlegen und Mitglieder verwalten.

.DESCRIPTION
    - Globale Sicherheitsgruppe anlegen
    - Mitglied hinzufügen / entfernen
    - Mitgliedschaft prüfen (vorwärts und rückwärts)
#>

Import-Module ActiveDirectory

$ouGroups = "OU=Gruppen,OU=PWSAD,$((Get-ADDomain).DistinguishedName)"

# 1. Gruppe anlegen
New-ADGroup -Name 'PWSAD-IT'   -SamAccountName 'PWSAD-IT' `
            -GroupCategory Security -GroupScope Global `
            -Path $ouGroups -Description 'Demo: IT-Mitarbeiter'

# 2. Mitglied hinzufügen
Add-ADGroupMember -Identity 'PWSAD-IT' -Members 'm.mustermann'

# 3. Mitgliedschaft prüfen
Get-ADGroupMember -Identity 'PWSAD-IT' | Format-Table Name, SamAccountName

# 4. Umgekehrt: Welche Gruppen hat der User?
Get-ADPrincipalGroupMembership -Identity 'm.mustermann' |
    Select-Object Name, GroupCategory, GroupScope

# 5. Mitglied entfernen (Bestätigung)
Remove-ADGroupMember -Identity 'PWSAD-IT' -Members 'm.mustermann' -Confirm:$false
