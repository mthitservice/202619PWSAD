<#
.SYNOPSIS
    Übungs-Stub: OU-Struktur für die Übungen anlegen.

.DESCRIPTION
    Wird in der Live-Demo gemeinsam erarbeitet.
    Ziel: unterhalb der Domäne eine Basis-OU 'PWSAD' und passende
    Sub-OUs (Benutzer, Gruppen, Computer, ServiceAccounts, Deaktiviert)
    anlegen.

    Hinweise:
    - Modul ActiveDirectory laden
    - Domain-DN ermitteln  ($Domain = (Get-ADDomain).DistinguishedName)
    - Idempotent prüfen (Get-ADOrganizationalUnit -Filter ...)
    - ProtectedFromAccidentalDeletion beachten
#>

Import-Module ActiveDirectory

# TODO: $domainDN ermitteln
# TODO: Basis-OU 'PWSAD' anlegen
# TODO: Sub-OUs in Schleife anlegen
# TODO: Ergebnis mit Get-ADOrganizationalUnit prüfen
