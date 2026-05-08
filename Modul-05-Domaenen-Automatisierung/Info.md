# Modul 05 – Automatisierung in der Domäne

> **Lernziel:** Forest- und DC-Installation, OU-Struktur und Massenimport
> von Benutzern vollständig per PowerShell automatisieren.

## Themen

1. **Neue Gesamtstruktur** installieren – `Install-ADDSForest`
2. **Zusätzlichen DC** einer bestehenden Domäne hinzufügen –
   `Install-ADDSDomainController`
3. **OU-Struktur** aus einer JSON-/CSV-Definition aufbauen
4. **Massenimport von Benutzern** aus CSV
   - Mapping CSV-Spalten → AD-Attribute
   - Initialpasswörter
   - Gruppen-Zuweisung
   - Idempotenz (Skript darf mehrfach laufen)

## Best Practices Massenimport

- CSV mit **`;` Delimiter** und **UTF-8** speichern
- Validieren vor dem Schreiben (`Test-…` Funktionen)
- Skripte **idempotent** schreiben (existiert? → updaten, sonst anlegen)
- Logging in eine Transcript-Datei: `Start-Transcript`
- Sicherheit: Passwörter **nie** in Klartext-CSV – stattdessen generieren
  und sicher (z. B. verschlüsselt per DPAPI / Vault) ablegen

## Microsoft Learn

- <https://learn.microsoft.com/powershell/module/addsdeployment/install-addsforest>
- <https://learn.microsoft.com/powershell/module/addsdeployment/install-addsdomaincontroller>
- <https://learn.microsoft.com/powershell/module/activedirectory/new-aduser>
