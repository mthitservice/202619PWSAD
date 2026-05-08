# Modul 06 – AD-Gruppen-Audit & NTFS-Berechtigungen (Zusatzmodul)

## Lernziele

- Leere AD-Gruppen (0 Mitglieder, auch rekursiv) identifizieren.
- Alle Ordner eines Fileservers finden, auf denen eine bestimmte
  AD-Gruppe per NTFS berechtigt ist.
- Ergebnisse als CSV/Tabelle aufbereiten.

## Hintergrund

In gewachsenen Umgebungen sammeln sich „verwaiste" Sicherheitsgruppen.
Das verstößt gegen das Prinzip *least privilege* und erschwert Audits.
Typische Fragestellungen:

| Frage | Cmdlet / Technik |
|------|------------------|
| Welche Gruppen haben **keine** Mitglieder? | `Get-ADGroup` + `Get-ADGroupMember` |
| Welche haben auch rekursiv keine Mitglieder? | `Get-ADGroupMember -Recursive` |
| Wo wird Gruppe X berechtigt? | `Get-Acl` über alle Verzeichnisse |
| Auf welchen Shares? | `Get-SmbShare` + `Get-SmbShareAccess` |

## AGDLP-Bezug

Berechtigungen werden ausschließlich an **DL-Gruppen** vergeben
(siehe Modul 01). Ein Audit zeigt schnell, ob jemand das Modell
verletzt hat – etwa User direkt in DL oder G-Gruppen auf NTFS.

## Microsoft Learn

- [Get-ADGroup](https://learn.microsoft.com/powershell/module/activedirectory/get-adgroup)
- [Get-ADGroupMember](https://learn.microsoft.com/powershell/module/activedirectory/get-adgroupmember)
- [Get-Acl](https://learn.microsoft.com/powershell/module/microsoft.powershell.security/get-acl)
- [Get-SmbShareAccess](https://learn.microsoft.com/powershell/module/smbshare/get-smbshareaccess)
