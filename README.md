# 202619 PWSAD – PowerShell 5.0 für Active Directory (Vertiefung)

2-Tage-Webinar zur Vertiefung von Windows PowerShell 5.0 im Active-Directory-Umfeld.

- **Trainer:** Michael Lindner
- **Teilnehmer:** 3
- **Trainings-Domäne:** `ITH-xx.local` (xx = Teilnehmernummer 01..03)
- **Standort / AD-Site:** Dresden
- **Lab:** Hyper-V, internes Subnetz `10.10.0.0/24`

## Zielgruppe

IT-Administrator:innen mit PowerShell-Grundkenntnissen, die Active Directory
mit Bordmitteln automatisieren möchten.

## Kursziele

Nach dem Kurs können die Teilnehmenden mit PowerShell:

- AD-Basisobjekte (Benutzer, Gruppen, OUs, Computer) anlegen, ändern, löschen
- Active Directory konfigurieren und fein abgestimmte Kennwortrichtlinien (PSO) einsetzen
- Konten verwalten (sperren, deaktivieren, verschieben, Reports) und gelöschte
  Objekte aus dem AD-Papierkorb wiederherstellen
- FSMO-Betriebsmasterrollen anzeigen, übertragen und im Notfall beschlagnahmen
- Forest- und DC-Installation, OU-Strukturen und Massenimporte automatisieren

## Kursinhalt

| Modul | Thema |
|-------|-------|
| 01 | AD-Basisobjekte (CRUD: Benutzer, Gruppen, OUs, Computer) |
| 02 | AD-Konfiguration & Fine-Grained Password Policies |
| 03 | Kontoverwaltung & AD-Papierkorb |
| 04 | Betriebsmasterrollen (FSMO) |
| 05 | Domänen-Automatisierung (Forest-Install, DC hinzufügen, OU-Generator, User-Bulk-Import) |

## Ordnerstruktur

```
Lab-Setup/                          Hyper-V-Aufbau, Core-DC, Jumpserver, GPOs
Modul-01-AD-Basisobjekte/
Modul-02-AD-Konfiguration/
Modul-03-Kontoverwaltung/
Modul-04-Betriebsmasterrollen/
Modul-05-Domaenen-Automatisierung/
```

Jedes Modul enthält:

| Ordner       | Inhalt                                                   |
|--------------|----------------------------------------------------------|
| `Info.md`    | Theorie, Verweise auf Microsoft Learn                    |
| `Beispiele/` | Demo-Skripte mit Kommentaren (gemeinsame Durcharbeitung) |
| `Uebungen/`  | Praxis-Aufgaben zum eigenständigen Bearbeiten            |

## Lab-Umgebung

- Hyper-V Host
- Internes Subnetz: `10.10.0.0/24`
- **DC01** – Windows Server 2025 **Core**, AD DS, DNS
- **JUMP01** – Windows Server 2025 **Desktop Experience**, RSAT, VS Code
- Weitere Member-/Client-VMs werden modulweise hinzugefügt
- GPOs zur komfortablen Remote-Verwaltung der Core-Server

Details und Schritt-für-Schritt-Anleitungen siehe
[Lab-Setup/00-Uebersicht.md](Lab-Setup/00-Uebersicht.md).

## Passwort-Konvention (Trainingsumgebung)

> **Nur für die Lab-/Trainingsumgebung!** Niemals in produktiven Systemen verwenden.

| Verwendung                                                                | Passwort         |
|---------------------------------------------------------------------------|------------------|
| Lokales Administrator-Konto auf VMs (DC-Core, JUMP01, Member-VMs), DSRM   | <code>Pa&#36;&#36;w0rd202619</code> |
| Domain-Konten (Initialpasswort, Resets, Demo-/Übungs-User)                | `Pa55w.rd202619`   |

Alle Skripte und Übungen verwenden diese beiden Werte konsequent.
Domain-User werden mit `ChangePasswordAtLogon = $true` angelegt, damit
beim ersten Logon ein eigenes Passwort gewählt wird.

## Voraussetzungen für die Teilnahme

- Hyper-V-fähiger Rechner mit mindestens 16 GB RAM
- Windows Server 2025 ISO
- Webinar-Tool (Teams) inklusive Headset und Bildschirmfreigabe
- Grundlegende PowerShell-Kenntnisse (Cmdlets, Pipeline, Variablen)

## Ablauf

1. **Tag 1**
   - Lab-Vorbereitung gemeinsam mit den Teilnehmenden (Hyper-V, DC01-Core, JUMP01)
   - Modul 01 – AD-Basisobjekte
   - Modul 02 – AD-Konfiguration & FGPP
2. **Tag 2**
   - Modul 03 – Kontoverwaltung & AD-Papierkorb
   - Modul 04 – Betriebsmasterrollen
   - Modul 05 – Domänen-Automatisierung
   - Wrap-up, offene Fragen

