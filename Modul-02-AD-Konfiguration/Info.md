# Modul 02 – Active Directory konfigurieren & Fine-Grained Password Policies

> **Lernziel:** Domänen-Default-Policy verstehen, AD per PowerShell
> konfigurieren, **fein abgestimmte Kennwortrichtlinien (FGPP / PSO)** für
> einzelne Gruppen anlegen und anwenden.

## Themen

1. Domänen-Standard-Kennwortrichtlinie auslesen
   (`Get-ADDefaultDomainPasswordPolicy`)
2. Globale AD-Eigenschaften setzen (`Set-ADDomain`, `Set-ADForest`)
3. **PSO** – Password Settings Object
   - `New-ADFineGrainedPasswordPolicy`
   - `Add-ADFineGrainedPasswordPolicySubject`
   - Anwendung anhand `msDS-ResultantPSO`
4. Vorrang (Precedence) bei mehreren PSOs

## Wichtige Punkte

- PSOs werden im Container `CN=Password Settings Container,CN=System,...` gespeichert
- PSOs werden direkt an **User oder globale Gruppen** gebunden
- Niedrigere `Precedence` = höhere Priorität
- Nur **ein** wirksames PSO pro Benutzer (`Get-ADUserResultantPasswordPolicy`)

## Microsoft Learn

- <https://learn.microsoft.com/windows-server/identity/ad-ds/get-started/adac/introduction-to-active-directory-administrative-center-enhancements--level-100->
- <https://learn.microsoft.com/powershell/module/activedirectory/new-adfinegrainedpasswordpolicy>
