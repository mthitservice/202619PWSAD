# Modul 01 – Übungen: AD-Basisobjekte

> Domäne: `ITH-01.local` · Basis-OU: `OU=PWSAD,DC=ITH-01,DC=local`
> Alle Übungen auf **JUMP01** als Domänen-Admin in einer **PowerShell-Konsole**
> ausführen. `Import-Module ActiveDirectory` zuerst.

---

## Übung 1.1 – OU-Struktur erweitern

Lege unterhalb von `OU=PWSAD` die OU `Abteilungen` an und darin die OUs
`Vertrieb`, `Buchhaltung` und `Produktion`.

- Alle OUs **gegen versehentliches Löschen** schützen.
- Beschreibung: `Abteilung <Name>`.
- Prüfe das Ergebnis mit `Get-ADOrganizationalUnit`.

## Übung 1.2 – Benutzer anlegen

Lege folgende Benutzer in `OU=Vertrieb,OU=Abteilungen,OU=PWSAD,…` an:

| Vorname | Nachname  | Login (SAM) | Titel             |
|---------|-----------|-------------|-------------------|
| Anna    | Schmidt   | a.schmidt   | Vertriebsleitung  |
| Bernd   | Becker    | b.becker    | Account Manager   |
| Clara   | Conrad    | c.conrad    | Account Manager   |

- UPN-Schema: `<sam>@ITH-01.local`
- Initialpasswort: `Pa55w.rd2619` (Standard-Domain-Initialpasswort, siehe README)
- Konto **aktiviert**, Passwortwechsel beim ersten Anmelden erzwingen.

## Übung 1.3 – Gruppen und Mitgliedschaften

1. Lege die globale Sicherheitsgruppe `G-Vertrieb` in `OU=Gruppen,OU=PWSAD` an.
2. Füge alle drei Vertriebs-Benutzer auf einen Schlag hinzu (Pipeline!).
3. Lege eine domänenlokale Gruppe `DL-Vertrieb-Read` an und füge `G-Vertrieb`
   als Mitglied hinzu (AGDLP-Prinzip).
4. Gib aus: alle Mitglieder von `DL-Vertrieb-Read` **rekursiv** (`-Recursive`).

## Übung 1.4 – Computer pre-stagen

Lege in `OU=Computer,OU=PWSAD` zwei Computer-Konten an: `CL01` und `CL02`,
beide aktiviert, mit Beschreibung `Übungs-Client`.

## Übung 1.5 – Massenänderung

Setze für **alle** Benutzer in `OU=Vertrieb` die Eigenschaft
`Department = 'Vertrieb'` und `Company = 'ITH-01 GmbH'` in **einem** Befehl
(Pipeline aus `Get-ADUser` nach `Set-ADUser`).

## Übung 1.6 – Aufräumen

Lösche die OU `Abteilungen` inklusive aller Unter-Objekte.
Achte auf den Löschschutz und nutze `-Recursive`.

---

## Bonus

- Erstelle alle Vertriebs-Benutzer **aus einer Hashtable-Liste** (Schleife).
- Nutze `Splatting` (`@params`) für übersichtlichen Code.
