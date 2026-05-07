<#
.SYNOPSIS
    Trainer-Demo: Fein abgestimmte Kennwortrichtlinie (PSO) für Admins.

.DESCRIPTION
    - Erzeugt globale Gruppe 'G-Admins-Strong'
    - Erzeugt PSO 'PSO-Admins' mit strengen Vorgaben
    - Bindet PSO an die Gruppe
    - Zeigt das resultierende PSO für ein Mitglied
#>

Import-Module ActiveDirectory

$domainDN = (Get-ADDomain).DistinguishedName
$ouGroups = "OU=Gruppen,OU=PWSAD,$domainDN"

# 1. Gruppe
if (-not (Get-ADGroup -Filter "Name -eq 'G-Admins-Strong'" -EA SilentlyContinue)) {
    New-ADGroup -Name 'G-Admins-Strong' -SamAccountName 'G-Admins-Strong' `
        -GroupCategory Security -GroupScope Global -Path $ouGroups
}

# 2. PSO
if (-not (Get-ADFineGrainedPasswordPolicy -Filter "Name -eq 'PSO-Admins'" -EA SilentlyContinue)) {
    New-ADFineGrainedPasswordPolicy `
        -Name                       'PSO-Admins' `
        -Precedence                 10 `
        -ComplexityEnabled          $true `
        -ReversibleEncryptionEnabled $false `
        -MinPasswordLength          16 `
        -PasswordHistoryCount       24 `
        -MinPasswordAge             (New-TimeSpan -Days 1) `
        -MaxPasswordAge             (New-TimeSpan -Days 90) `
        -LockoutThreshold           5 `
        -LockoutObservationWindow   (New-TimeSpan -Minutes 30) `
        -LockoutDuration            (New-TimeSpan -Minutes 30) `
        -Description                'Strenge Policy für Administratoren'
}

# 3. Bindung an die Gruppe
Add-ADFineGrainedPasswordPolicySubject -Identity 'PSO-Admins' -Subjects 'G-Admins-Strong'

# 4. Wirksames PSO für einen Test-Benutzer abfragen
# Get-ADUserResultantPasswordPolicy -Identity 'a.schmidt'
Get-ADFineGrainedPasswordPolicy -Filter * |
    Format-Table Name, Precedence, MinPasswordLength, MaxPasswordAge
