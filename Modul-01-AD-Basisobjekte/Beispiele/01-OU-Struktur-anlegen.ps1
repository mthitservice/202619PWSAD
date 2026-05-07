<#
.SYNOPSIS
    Trainer-Demo: OU-Struktur für die Übungen anlegen.

.DESCRIPTION
    Legt unterhalb der Domänen-Wurzel die Basis-OU 'PWSAD' an und darunter
    die Sub-OUs, die in den Übungen verwendet werden.

    Wichtig:
    - 'New-ADOrganizationalUnit' setzt standardmäßig
      ProtectedFromAccidentalDeletion = $true. Zum Löschen in der Demo
      muss dieser Schutz erst entfernt werden.

.NOTES
    Auf JUMP01 als Domänen-Admin ausführen.
#>

Import-Module ActiveDirectory

$domainDN = (Get-ADDomain).DistinguishedName    # z. B. DC=ITH-01,DC=local
$basis    = "OU=PWSAD,$domainDN"

# Idempotent: nur anlegen, wenn nicht vorhanden
if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$basis'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name 'PWSAD' -Path $domainDN `
        -Description 'Trainings-Wurzel für PowerShell AD-Kurs' `
        -ProtectedFromAccidentalDeletion $true
    Write-Host "OU 'PWSAD' angelegt" -ForegroundColor Green
}

# Sub-OUs
$subOUs = 'Benutzer','Gruppen','Computer','ServiceAccounts','Deaktiviert'
foreach ($ou in $subOUs) {
    $dn = "OU=$ou,$basis"
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$dn'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $ou -Path $basis `
            -ProtectedFromAccidentalDeletion $true
        Write-Host "  + $ou" -ForegroundColor Green
    }
}

Get-ADOrganizationalUnit -SearchBase $basis -Filter * |
    Select-Object Name, DistinguishedName |
    Format-Table -AutoSize
