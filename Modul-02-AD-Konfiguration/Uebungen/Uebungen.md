# Modul 02 – Übungen: AD-Konfiguration & FGPP

## Übung 2.1 – Default Domain Policy dokumentieren

Lies die aktuelle Default-Domain-Password-Policy aus und exportiere sie als
**JSON** nach `C:\PWSAD\Reports\DefaultPwdPolicy.json`.

## Übung 2.2 – Default Policy anpassen

Setze für die Domäne:

- Mindestlänge **10**
- History **12**
- Max-Age **180 Tage**
- Sperrschwelle **10 fehlgeschlagene Versuche**
- Sperrdauer **15 min**

## Übung 2.3 – PSO für Service-Accounts

1. Lege die Gruppe `G-ServiceAccounts` in `OU=Gruppen,OU=PWSAD` an.
2. Erstelle ein PSO `PSO-Services`:
   - Mindestlänge 24
   - Komplexität an
   - **MaxPasswordAge = 0** (Passwort läuft nicht ab)
   - Precedence 20
3. Binde das PSO an `G-ServiceAccounts`.
4. Lege einen Test-User `svc-demo` in `OU=ServiceAccounts,OU=PWSAD` an,
   nimm ihn in die Gruppe auf, und zeige mit
   `Get-ADUserResultantPasswordPolicy` das wirksame PSO.

## Übung 2.4 – Vorrang vergleichen

- Erzeuge ein zweites PSO `PSO-Services-Strict` mit Precedence **15**
  und Mindestlänge **30**.
- Binde es ebenfalls an `G-ServiceAccounts`.
- Welches PSO wirkt nun für `svc-demo`? Begründe anhand der Precedence.
