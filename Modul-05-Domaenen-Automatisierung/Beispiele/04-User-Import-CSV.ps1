<#
.SYNOPSIS
    Trainer-Demo: Bulk-Import von Benutzern aus CSV.

.DESCRIPTION
    - Liest CSV (Delimiter ';', UTF-8)
    - Erstellt User idempotent (Update bei Existenz)
    - Setzt Initialpasswort + ChangePasswordAtLogon
    - Fügt zur in der CSV angegebenen Gruppe hinzu

.EXAMPLE
    .\04-User-Import-CSV.ps1 -CsvPath .\Benutzer.csv
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $CsvPath,
    [string] $InitialPassword = 'Pa55w.rd2619'
)

Import-Module ActiveDirectory
Start-Transcript -Path "C:\PWSAD\Reports\Import-$(Get-Date -f yyyyMMdd-HHmmss).log" -Force

$pwd = ConvertTo-SecureString $InitialPassword -AsPlainText -Force
$rows = Import-Csv -Path $CsvPath -Delimiter ';' -Encoding UTF8

foreach ($r in $rows) {
    $sam = $r.SamAccountName
    $existing = Get-ADUser -Filter "SamAccountName -eq '$sam'" -EA SilentlyContinue

    $params = @{
        GivenName         = $r.GivenName
        Surname           = $r.Surname
        DisplayName       = "{0}, {1}" -f $r.Surname, $r.GivenName
        Department        = $r.Department
        Title             = $r.Title
        Office            = $r.Office
        Company           = 'ITH-01 GmbH'
    }

    if ($existing) {
        Set-ADUser -Identity $existing @params
        Write-Host "= updated $sam" -ForegroundColor DarkGray
    } else {
        New-ADUser @params `
            -Name              "$($r.GivenName) $($r.Surname)" `
            -SamAccountName    $sam `
            -UserPrincipalName "$sam@ITH-01.local" `
            -Path              $r.OU `
            -AccountPassword   $pwd `
            -Enabled           $true `
            -ChangePasswordAtLogon $true
        Write-Host "+ created $sam" -ForegroundColor Green
    }

    if ($r.Group) {
        Add-ADGroupMember -Identity $r.Group -Members $sam -EA SilentlyContinue
    }
}

Stop-Transcript
