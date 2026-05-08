# Modul 05 – Übungen: Domänen-Automatisierung

## Übung 5.1 – Forest-Install (Lab)

In einer **separaten Test-VM** (z. B. `LAB02`):

1. Statische IP konfigurieren (`10.10.0.40/24`, DNS `10.10.0.10`).
2. Hostname `LAB02` setzen.
3. Mit `Install-ADDSForest` eine **eigene** Test-Forest `lab.local` aufsetzen.

> Achtung: Nur in einer eigenen VM, nicht auf JUMP01 oder DC01!

## Übung 5.2 – DC02 hinzufügen

1. Neue VM `DC02` mit Server 2025 Core, IP `10.10.0.11`, DNS `10.10.0.10`.
2. Domain-Join zu `ITH-01.local`.
3. Auf `DC02` per PowerShell `Install-ADDSDomainController` ausführen.
4. Auf JUMP01 prüfen:
   ```powershell
   Get-ADDomainController -Filter * | Format-Table HostName, Site
   ```

## Übung 5.3 – OU-Struktur-Generator

Erweitere die JSON-Datei `OU-Struktur.json` um einen dritten Standort
`Berlin` mit den Sub-OUs `Benutzer`, `Computer`, `Gruppen`.
Führe `03-OU-Struktur-aus-JSON.ps1` aus und prüfe, dass keine
duplizierten OUs entstehen, wenn das Skript ein zweites Mal läuft.

## Übung 5.4 – CSV-Bulk-Import

1. Erweitere `Benutzer.csv` um **5 weitere** Benutzer (verteile sie auf
   die Standorte Dresden, Leipzig, Berlin).
2. Führe `04-User-Import-CSV.ps1` aus.
3. Prüfe per `Get-ADUser -Filter * -SearchBase 'OU=ITH-Org,…'`, dass alle
   User sauber angelegt wurden.

## Übung 5.5 – Eigene Bulk-Funktion

Schreibe eine Funktion `Import-ItHUser` mit Parametern
`-CsvPath`, `-DefaultPassword`, die:

- Daten validiert (Pflichtspalten vorhanden?)
- Einen Report `C:\PWSAD\Reports\Import-Result.csv` erzeugt mit
  Spalten `SamAccountName`, `Status` (`Created` / `Updated` / `Failed`),
  `Error`.
- `-WhatIf` und `-Confirm` unterstützt (`SupportsShouldProcess`).
