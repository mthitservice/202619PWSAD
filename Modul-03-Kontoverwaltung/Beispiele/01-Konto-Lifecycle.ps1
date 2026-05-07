<#
.SYNOPSIS
    Trainer-Demo: Konto-Lebenszyklus.
#>

Import-Module ActiveDirectory

# Gesperrte Konten finden + entsperren
Search-ADAccount -LockedOut |
    ForEach-Object {
        Write-Host "Entsperre $($_.SamAccountName)" -ForegroundColor Yellow
        Unlock-ADAccount -Identity $_
    }

# Inaktive Konten der letzten 90 Tage
Search-ADAccount -AccountInactive -TimeSpan (New-TimeSpan -Days 90) -UsersOnly |
    Select-Object Name, SamAccountName, LastLogonDate |
    Format-Table -AutoSize

# Passwort zurücksetzen
$pwd = ConvertTo-SecureString 'Pa55w.rd2619' -AsPlainText -Force
Set-ADAccountPassword -Identity 'a.schmidt' -Reset -NewPassword $pwd
Set-ADUser            -Identity 'a.schmidt' -ChangePasswordAtLogon $true

# Konto in 'Deaktiviert'-OU verschieben + deaktivieren
$domainDN  = (Get-ADDomain).DistinguishedName
$ouDeact   = "OU=Deaktiviert,OU=PWSAD,$domainDN"
Disable-ADAccount -Identity 'a.schmidt'
Move-ADObject -Identity (Get-ADUser 'a.schmidt').DistinguishedName -TargetPath $ouDeact
