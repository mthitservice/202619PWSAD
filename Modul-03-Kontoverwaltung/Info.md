# Modul 03 – Verwaltung von AD-Konten & AD-Papierkorb

> **Lernziel:** Den Lebenszyklus von AD-Konten beherrschen
> (sperren, entsperren, deaktivieren, verschieben, Passwort-Reset, Reports)
> und gelöschte Objekte mit dem AD-Papierkorb wiederherstellen.

## Themen

- Konten **sperren / entsperren**: `Unlock-ADAccount`, `Search-ADAccount`
- **Aktivieren / Deaktivieren**: `Enable-ADAccount`, `Disable-ADAccount`
- **Passwort zurücksetzen**: `Set-ADAccountPassword -Reset`
- **Verschieben** zwischen OUs: `Move-ADObject`
- **Inaktive Konten** finden: `Search-ADAccount -AccountInactive`
- **AD-Papierkorb (Recycle Bin)** aktivieren und nutzen
  - `Enable-ADOptionalFeature`
  - `Get-ADObject -IncludeDeletedObjects`
  - `Restore-ADObject`

## Hinweis zum AD-Papierkorb

- Einmal aktiviert, **nicht mehr deaktivierbar**.
- Voraussetzung: Forest Functional Level **2008 R2** oder höher.
- Standard-Lebensdauer gelöschter Objekte: **180 Tage** (`tombstoneLifetime`).

## Microsoft Learn

- <https://learn.microsoft.com/windows-server/identity/ad-ds/get-started/adac/active-directory-administrative-center--level-100->
- <https://learn.microsoft.com/powershell/module/activedirectory/restore-adobject>
