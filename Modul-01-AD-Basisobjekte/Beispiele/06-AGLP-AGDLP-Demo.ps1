<#
.SYNOPSIS
    Übungs-Stub: AGLP / AGDLP-Prinzip durchsetzen.

.DESCRIPTION
    Wird in der Live-Demo gemeinsam erarbeitet.

    Schichten:
        Account (User)
          → Global Group (G-…)
            → Domain-Local Group (DL-…)
              → Permission (NTFS Modify auf C:\Shares\Vertrieb)

    Regel: Benutzer NIE direkt in DL-Gruppen, Berechtigungen NIE direkt
    an User oder G-Gruppen vergeben.

    Siehe ../Info.md  Abschnitt "AGLP / AGDLP".
#>

Import-Module ActiveDirectory

# TODO: G-Vertrieb (Global) und DL-Share-Vertrieb-RW (DomainLocal) anlegen
# TODO: G-Gruppe in DL-Gruppe verschachteln
# TODO: C:\Shares\Vertrieb anlegen + SmbShare
# TODO: NTFS-Vererbung deaktivieren, Modify NUR an DL-Gruppe vergeben
# TODO: Verifizieren: Get-Acl, Get-ADGroupMember -Recursive
