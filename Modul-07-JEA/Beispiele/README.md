# M13 – Übungen: Just Enough Administration

> Diese Übungen erfordern **lokale Admin-Rechte** und sollten in einer Test-VM ausgeführt werden.

## Übung 13.1 – Helpdesk-Endpoint
Erstelle einen JEA-Endpoint `JEA_Helpdesk`, der für die Gruppe `BUILTIN\Users` (oder eine eigene AD-Gruppe) folgende Operationen erlaubt:

- `Get-Service` (alle)
- `Restart-Service` **nur** für `Spooler` und `BITS`
- eine Funktion `Get-DiskFree`, die freien Platz `%` ausgibt

## Übung 13.2 – Test
- Verbinde dich aus einer **anderen** Session mit dem Endpoint:
  ```powershell
  Enter-PSSession -ComputerName localhost -ConfigurationName JEA_Helpdesk
  ```
- Prüfe `Get-Command` (sollte minimal sein)
- Versuche `Stop-Computer` (muss blockiert sein)

## Übung 13.3 – Transcript
Aktiviere Transcripts in `C:\JEA\Transcripts` und sieh dir die Logs nach einem Test-Lauf an.

Starter: [`Setup-JEA.ps1`](Setup-JEA.ps1)
