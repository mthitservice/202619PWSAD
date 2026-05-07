<#
.SYNOPSIS
    Übungs-Stub: Benutzer mit allen wichtigen Eigenschaften anlegen.

.DESCRIPTION
    Wird in der Live-Demo gemeinsam erarbeitet.
    Ziel: einen Demo-User in OU=Benutzer,OU=PWSAD,... anlegen und die
    wichtigsten Properties (Sam, UPN, DisplayName, Department, Title,
    Office) korrekt setzen.

    Hinweise:
    - Splatting verwenden ($params = @{ ... })
    - Passwort mit ConvertTo-SecureString -AsPlainText -Force
    - Initialpasswort:  Pa55w.rd2619
    - ChangePasswordAtLogon = $true
#>

Import-Module ActiveDirectory

# TODO: OU-Pfad bestimmen
# TODO: SecureString für das Initialpasswort erzeugen
# TODO: Hashtable mit New-ADUser-Parametern (Splatting) befüllen
# TODO: New-ADUser @params
# TODO: Ergebnis mit Get-ADUser -Properties prüfen
