# Modul 01 – Active Directory-Basisobjekte mit PowerShell

> **Lernziel:** Sicheres Anlegen, Ändern und Löschen von Benutzern, Gruppen,
> OUs und Computern mit dem Modul `ActiveDirectory`.

## Überblick

Das Modul `ActiveDirectory` (Teil von RSAT) stellt Cmdlets für alle Basis-
operationen bereit. Die Cmdlets folgen dem Schema `Verb-AD<Objekt>`.

| Objekt    | Anlegen          | Lesen        | Ändern       | Löschen        |
|-----------|------------------|--------------|--------------|----------------|
| Benutzer  | `New-ADUser`     | `Get-ADUser` | `Set-ADUser` | `Remove-ADUser`|
| Gruppe    | `New-ADGroup`    | `Get-ADGroup`| `Set-ADGroup`| `Remove-ADGroup`|
| OU        | `New-ADOrganizationalUnit` | `Get-ADOrganizationalUnit` | `Set-ADOrganizationalUnit` | `Remove-ADOrganizationalUnit` |
| Computer  | `New-ADComputer` | `Get-ADComputer` | `Set-ADComputer` | `Remove-ADComputer` |

## Wichtige Punkte

- **Distinguished Name (DN)** vs. **SamAccountName** vs. **UPN**
- `-Path` definiert den Container (DN) beim Anlegen
- OUs sind standardmäßig **vor versehentlichem Löschen geschützt**
  (`ProtectedFromAccidentalDeletion = $true`)
- Pipelining: `Get-ADUser ... | Set-ADUser ...` / `... | Remove-ADUser`

## Trainings-Domäne

- Domäne: `ITH-01.local`
- Basis-OU für Übungen: `OU=PWSAD,DC=ITH-01,DC=local`

## Microsoft Learn

- <https://learn.microsoft.com/powershell/module/activedirectory/>
- <https://learn.microsoft.com/windows-server/identity/ad-ds/manage/component-updates/active-directory-administrative-center>

## Inhalt dieses Moduls

- [Beispiele/](Beispiele/) – Trainer-Demos mit Erklärungen
- [Uebungen/](Uebungen/) – Praxis für Teilnehmer
- `Loesungen/` – Trainer-Lösungen (per `.gitignore` ausgeblendet)
