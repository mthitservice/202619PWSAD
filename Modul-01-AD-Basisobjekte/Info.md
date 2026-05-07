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

## AGLP / AGDLP – das Gruppenmodell

Microsoft empfiehlt seit Jahrzehnten ein konsequentes Gruppen-Schichten-Modell.
Damit bleibt die Berechtigungsvergabe übersichtlich und skaliert.

| Buchstabe | Bedeutung                                  | Beispiel              |
|-----------|--------------------------------------------|-----------------------|
| **A**     | **Account** – das Benutzerkonto            | `a.schmidt`           |
| **G**     | **Global Group** – fasst Konten zusammen   | `G-Vertrieb`          |
| **DL**    | **Domain-Local Group** – wird auf der Ressource berechtigt | `DL-Share-Vertrieb-RW` |
| **L**     | **Local** (Single-Domain-Variante: lokale Gruppe auf dem Server) | `Datei-Vertrieb-RW` |
| **P**     | **Permission** – das eigentliche NTFS-/Share-/Service-Recht | `Modify` |

```
A  →  G          →  DL              →  P
User    Globale         Domänen-          Recht (NTFS,
        Gruppe          lokale            Freigabe, Dienst …)
        (organi-        Gruppe
        satorisch)      (technisch)
```

**Regeln:**

- Benutzer **nur in globale Gruppen** (G) aufnehmen – nie direkt in DL.
- Globale Gruppen **in domänenlokale Gruppen** (DL) verschachteln.
- **Berechtigungen ausschließlich** an domänenlokalen Gruppen vergeben.
- Pro Ressource und Recht eine eigene DL: `DL-<Ressource>-<RW|R|FC>`.

**Vorteile:**

- Mitarbeiterwechsel = nur Mitgliedschaft in **G** ändern.
- Neues Recht auf einer Ressource = nur eine **DL** anpassen.
- Saubere Trennung: organisatorisch (G) vs. technisch (DL).

**Namens-Konvention im Kurs:**

- Globale Gruppen: `G-<Abteilung>` z. B. `G-Vertrieb`
- Domänenlokale Gruppen: `DL-<Ressource>-<Recht>` z. B. `DL-Share-Vertrieb-RW`

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
