<#
.SYNOPSIS
    Übungs-Stub: Alle Ordner auf einem Fileserver finden, auf denen eine
    bestimmte AD-Gruppe per NTFS berechtigt ist.

.DESCRIPTION
    Wird in der Live-Demo gemeinsam erarbeitet.
    Ziel: Beim Eintippen der Gruppe (z. B. DL-Share-Vertrieb-RW) eine
    Liste aller Ordner zurückgeben, in denen genau diese Gruppe in
    der NTFS-ACL erscheint.

    Hinweise:
    - Get-ChildItem -Recurse -Directory
    - Get-Acl
    - $acl.Access | Where-Object IdentityReference -like "*\<Gruppe>"
    - Optional: nur an Share-Wurzeln starten (Get-SmbShare)
#>

# TODO: Parameter: -GroupName, -Roots (z. B. C:\Shares)
# TODO: Roots durchwandern (Get-ChildItem -Directory -Recurse -Force)
# TODO: für jeden Ordner Get-Acl, IdentityReference vergleichen
# TODO: Ergebnis als PSCustomObject (Path, Rights, Inherited)
