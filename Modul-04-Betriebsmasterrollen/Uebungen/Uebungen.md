# Modul 04 – Übungen: Betriebsmasterrollen

> Voraussetzung: Modul 05 idealerweise begonnen, sodass `DC02` als
> zusätzlicher DC online ist. Sonst Übung 4.2 nur theoretisch besprechen.

## Übung 4.1 – FSMO-Inventur

Schreibe ein Skript, das **alle 5 FSMO-Rollen** als Tabelle ausgibt
und zusätzlich nach `C:\PWSAD\Reports\FSMO.json` exportiert.

## Übung 4.2 – Geplanter Transfer

Übertrage **PDC-Emulator** und **Infrastructure Master** von `DC01` auf `DC02`.
Verifiziere den Erfolg mit `Get-ADDomain`.

Übertrage anschließend die Rollen wieder zurück auf `DC01`.

## Übung 4.3 – Forest-Rollen

Übertrage **Schema Master** und **Domain Naming Master** von `DC01` auf `DC02`
und wieder zurück.

> Hinweis: Schema-Master-Transfers erfordern Mitgliedschaft in
> `Schema Admins`.

## Übung 4.4 – Notfall-Plan (Theorie)

Beschreibe in `Notfall.md`, welche Schritte du durchführst, wenn DC01
unwiederbringlich ausfällt und alle 5 Rollen hält.
Insbesondere: Welche Cmdlets, was darf der alte DC danach nie wieder?
