<#
.SYNOPSIS
    Trainer-Demo: Default-Domain-Password-Policy auslesen und ändern.
#>

Import-Module ActiveDirectory

Get-ADDefaultDomainPasswordPolicy |
    Format-List ComplexityEnabled, MinPasswordLength, MaxPasswordAge,
                MinPasswordAge, PasswordHistoryCount, LockoutThreshold,
                LockoutDuration, LockoutObservationWindow

# Beispiel: Komplexität AN, Mindestlänge 12, Historie 24
Set-ADDefaultDomainPasswordPolicy -Identity (Get-ADDomain).DistinguishedName `
    -ComplexityEnabled $true `
    -MinPasswordLength 12 `
    -PasswordHistoryCount 24 `
    -MaxPasswordAge (New-TimeSpan -Days 180)
