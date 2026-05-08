# Modul 13 – Just Enough Administration (JEA)

## Lernziele
- JEA-Konzept und Anwendungsfälle verstehen
- Role Capability File (`.psrc`) und Session Configuration File (`.pssc`) erstellen
- JEA-Endpoint registrieren und testen
- Sicherheit: virtuelles Konto, Constraint-Language-Mode

## Was ist JEA?

JEA ist ein Sicherheitsfeature von PowerShell Remoting, mit dem **eingeschränkte Admin-Endpoints** bereitgestellt werden. Ein normaler Benutzer kann darüber nur **ausgewählte Befehle** mit erhöhten Rechten ausführen, ohne Mitglied einer privilegierten Gruppe zu sein.

```
[ User ]  --PSRemoting-->  [ JEA Endpoint ]
                            ↳ Virtual Account (lokaler Admin)
                            ↳ erlaubte Cmdlets (z.B. Restart-Service DNS*)
```

## Voraussetzungen

- WinRM aktiv (`Enable-PSRemoting -Force`)
- Module-Verzeichnis: `C:\Program Files\WindowsPowerShell\Modules\<RoleName>\`

## 1) Role Capability File (`.psrc`)

```powershell
New-Item 'C:\Program Files\WindowsPowerShell\Modules\HelpdeskRole\RoleCapabilities' -ItemType Directory -Force

New-PSRoleCapabilityFile `
    -Path 'C:\Program Files\WindowsPowerShell\Modules\HelpdeskRole\RoleCapabilities\Helpdesk.psrc' `
    -VisibleCmdlets @(
        'Restart-Service',
        @{ Name = 'Get-Service'; Parameters = @{ Name = 'Name'; ValidateSet = 'Spooler','DNS' } }
    ) `
    -VisibleFunctions 'Restart-Spooler' `
    -FunctionDefinitions @{
        Name = 'Restart-Spooler'
        ScriptBlock = { Restart-Service -Name Spooler -Force }
    }
```

## 2) Session Configuration File (`.pssc`)

```powershell
New-PSSessionConfigurationFile `
    -Path 'C:\JEA\Helpdesk.pssc' `
    -SessionType RestrictedRemoteServer `
    -RunAsVirtualAccount `
    -TranscriptDirectory 'C:\JEA\Transcripts' `
    -RoleDefinitions @{
        'CONTOSO\Helpdesk' = @{ RoleCapabilities = 'Helpdesk' }
    }
```

## 3) Endpoint registrieren

```powershell
Register-PSSessionConfiguration `
    -Name 'JEA_Helpdesk' `
    -Path 'C:\JEA\Helpdesk.pssc' `
    -Force
```

## 4) Test

```powershell
# Als Helpdesk-User
Enter-PSSession -ComputerName srv01 -ConfigurationName JEA_Helpdesk
Get-Command            # nur erlaubte
Restart-Spooler        # ok
Restart-Service WinRM  # blockiert
```

## Sicherheits-Checkliste

- [ ] `RunAsVirtualAccount` (kein Klartext-Passwort)
- [ ] Transcripts aktivieren
- [ ] Nur benötigte Cmdlets/Parameter
- [ ] Constrained `Language Mode` (Standard in `RestrictedRemoteServer`)
- [ ] Tests mit niedrig privilegiertem User

## Microsoft Learn
- [JEA Overview](https://learn.microsoft.com/powershell/scripting/learn/remoting/jea/overview)
- [Role Capabilities](https://learn.microsoft.com/powershell/scripting/learn/remoting/jea/role-capabilities)
- [Session Configurations](https://learn.microsoft.com/powershell/scripting/learn/remoting/jea/session-configurations)

## Übungen
Siehe [`exercises/M13`](../exercises/M13/README.md).
