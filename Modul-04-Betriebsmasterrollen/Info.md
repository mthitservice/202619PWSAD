# Modul 04 – FSMO-Betriebsmasterrollen mit PowerShell

> **Lernziel:** FSMO-Rollen kennen, anzeigen, übertragen (transfer) und
> notfalls beschlagnahmen (seize).

## Die 5 FSMO-Rollen

| Rolle                 | Scope    | Zweck                                       |
|-----------------------|----------|---------------------------------------------|
| Schema Master         | Forest   | Schema-Änderungen                           |
| Domain Naming Master  | Forest   | Hinzufügen/Entfernen von Domänen            |
| RID Master            | Domain   | Vergibt RID-Pools                           |
| PDC Emulator          | Domain   | Zeitquelle, Passwort-Replikation, Lockout   |
| Infrastructure Master | Domain   | Cross-Domain-Referenzen                     |

## Wichtige Cmdlets

```powershell
Get-ADForest | Select-Object SchemaMaster, DomainNamingMaster
Get-ADDomain | Select-Object PDCEmulator, RIDMaster, InfrastructureMaster

# Sauberer Transfer (Quelle ist online)
Move-ADDirectoryServerOperationMasterRole `
    -Identity 'DC02' `
    -OperationMasterRole PDCEmulator, RIDMaster `
    -Confirm:$false

# Notfall: Seize (Quelle ist tot)
Move-ADDirectoryServerOperationMasterRole `
    -Identity 'DC02' `
    -OperationMasterRole SchemaMaster `
    -Force
```

## Hinweise

- `Move-…` mit `-Force` = Seize (nur wenn der alte Rollenhalter unrettbar tot ist)
- Nach dem Seize **darf** der alte Rollenhalter nicht mehr ans Netz
- PDC ist **Zeitquelle** der Domäne – externe NTP-Konfiguration nicht vergessen

## Microsoft Learn

- <https://learn.microsoft.com/windows-server/identity/ad-ds/plan/planning-operations-master-role-placement>
- <https://learn.microsoft.com/powershell/module/activedirectory/move-addirectoryserveroperationmasterrole>
