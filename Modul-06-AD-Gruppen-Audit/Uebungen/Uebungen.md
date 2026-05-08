# Übungen Modul 06 – AD-Gruppen-Audit

## Übung 6.1 – Leere Gruppen finden

1. Schreibe ein Skript, das alle Sicherheitsgruppen ausgibt, die
   **keine Mitglieder** haben.
2. Erweitere es um den Schalter `-Recursive`, damit auch
   verschachtelte Mitgliedschaften berücksichtigt werden
   (`Get-ADGroupMember -Recursive`).
3. Schließe Builtin-Gruppen aus.
4. Exportiere das Ergebnis nach `C:\Temp\LeereGruppen.csv`.

## Übung 6.2 – Wo ist Gruppe X berechtigt?

1. Lege die Demo-Struktur aus Modul 01 (`G-Vertrieb`,
   `DL-Share-Vertrieb-RW`, Share `\\JUMP01\Vertrieb`) an, falls noch
   nicht vorhanden.
2. Schreibe ein Skript mit Parameter `-GroupName`, das **alle Ordner**
   unterhalb von `C:\Shares` ausgibt, in denen die Gruppe in der
   NTFS-ACL erscheint.
3. Gib pro Treffer aus: Pfad, Rechte, ob vererbt.
4. Erweiterung: zusätzlich Share-Berechtigungen prüfen
   (`Get-SmbShareAccess`).

## Übung 6.3 – AGDLP-Verstöße aufspüren

Kombiniere beide Techniken:

1. Finde alle Sicherheitsgruppen, die **direkt auf NTFS-Pfaden**
   berechtigt sind, deren Scope aber **nicht DomainLocal** ist
   (Verstoß gegen AGDLP).
2. Gib pro Verstoß den Pfad, die Gruppe und ihren Scope aus.
