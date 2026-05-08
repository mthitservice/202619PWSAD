<#
.SYNOPSIS
    Übungs-Stub: Leere AD-Gruppen finden.

.DESCRIPTION
    Wird in der Live-Demo gemeinsam erarbeitet.
    Ziel: Alle Sicherheitsgruppen ausgeben, die keine Mitglieder haben –
    sowohl direkt als auch rekursiv.

    Hinweise:
    - Get-ADGroup -Filter * -Properties Members
    - Where-Object { $_.Members.Count -eq 0 }
    - für rekursiv: Get-ADGroupMember -Recursive
    - Builtin-Gruppen ggf. ausschließen
#>

Import-Module ActiveDirectory

# TODO: Alle Sicherheitsgruppen holen (GroupCategory -eq 'Security')
# TODO: Filter auf Members.Count -eq 0
# TODO: Optional rekursiv prüfen
# TODO: Sortiert ausgeben (Name, GroupScope, DistinguishedName)
