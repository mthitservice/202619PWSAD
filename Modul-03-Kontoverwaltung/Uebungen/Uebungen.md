# Modul 03 – Übungen: Kontoverwaltung & AD-Papierkorb

> Voraussetzung: Modul 01 abgeschlossen, Benutzer aus Übung 1.2 vorhanden
> oder mit `Beispiele\01-OU-Struktur-anlegen.ps1` und `02-Benutzer-anlegen.ps1`
> nachgezogen.

## Übung 3.1 – Report inaktive Konten

Erzeuge einen CSV-Bericht aller Benutzerkonten in der Domäne, die seit
**60 Tagen** nicht mehr angemeldet waren – nach
`C:\PWSAD\Reports\InaktiveKonten.csv`.
Felder: `Name`, `SamAccountName`, `LastLogonDate`, `Enabled`,
`DistinguishedName`.

## Übung 3.2 – Auto-Deaktivierung

Schreibe ein Skript, das alle inaktiven Konten (>90 Tage) **deaktiviert**
und in die OU `OU=Deaktiviert,OU=PWSAD` **verschiebt**.
Setze die Beschreibung auf
`Deaktiviert am <Datum> wegen Inaktivität`.

## Übung 3.3 – Passwort-Reset für eine ganze Gruppe

Setze für alle Mitglieder von `G-Vertrieb` das Standard-Domain-Initialpasswort
`Pa55w.rd2619` und erzwinge Passwortwechsel beim nächsten Logon.

## Übung 3.4 – AD-Papierkorb

1. Aktiviere den AD-Papierkorb (falls nicht aktiv).
2. Lege den Test-User `temp.user` an, lösche ihn wieder.
3. Stelle ihn aus dem Papierkorb wieder her.
4. Lösche eine OU `OU=TempOU,OU=PWSAD` mit einem Test-User darin und
   stelle **OU + User** wieder her (Reihenfolge beachten!).

## Übung 3.5 – Sammelaufgabe

Ein Mitarbeiter wurde gerade gekündigt: `b.becker`.
Schreibe **ein Skript**, das atomar:

1. das Konto deaktiviert,
2. ein langes Zufallspasswort setzt,
3. alle Gruppenmitgliedschaften außer `Domain Users` entfernt,
4. das Konto in `OU=Deaktiviert,OU=PWSAD` verschiebt,
5. die Beschreibung auf `Offboarding <Datum>` setzt.
