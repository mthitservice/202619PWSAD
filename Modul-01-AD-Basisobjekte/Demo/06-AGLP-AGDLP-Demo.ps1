<#
.SYNOPSIS
    Trainer-Demo: AGLP / AGDLP-Prinzip durchsetzen.

.DESCRIPTION
    Zeigt das saubere Schichten-Modell:
        Account (User)
          → Global Group (G-…)
            → Domain-Local Group (DL-…)
              → Permission (NTFS Modify auf C:\Shares\Vertrieb)

    Wir richten exemplarisch eine Dateifreigabe für die Abteilung
    "Vertrieb" auf JUMP01 ein und vergeben das Recht ausschließlich
    über die DL-Gruppe.

.NOTES
    Auf JUMP01 als Domänen-Admin ausführen.
    Voraussetzung: Benutzer aus 02-Benutzer-anlegen.ps1 vorhanden,
    OU-Struktur aus 01-OU-Struktur-anlegen.ps1 vorhanden.
#>

Import-Module ActiveDirectory

$domainDN = (Get-ADDomain).DistinguishedName
$ouGroups = "OU=Gruppen,OU=PWSAD,$domainDN"

# 1. (A) Konto vorhanden? – m.mustermann aus Beispiel 02
if (-not (Get-ADUser -Filter "SamAccountName -eq 'm.mustermann'" -EA SilentlyContinue)) {
    throw "Vorab '02-Benutzer-anlegen.ps1' ausführen."
}

# 2. (G) Globale Gruppe – fasst die Personen organisatorisch zusammen
if (-not (Get-ADGroup -Filter "Name -eq 'G-Vertrieb'" -EA SilentlyContinue)) {
    New-ADGroup -Name 'G-Vertrieb' -SamAccountName 'G-Vertrieb' `
        -GroupCategory Security -GroupScope Global `
        -Path $ouGroups -Description 'Mitarbeiter Abteilung Vertrieb'
}
Add-ADGroupMember -Identity 'G-Vertrieb' -Members 'm.mustermann' -EA SilentlyContinue

# 3. (DL) Domänenlokale Gruppe – wird auf der Ressource berechtigt
if (-not (Get-ADGroup -Filter "Name -eq 'DL-Share-Vertrieb-RW'" -EA SilentlyContinue)) {
    New-ADGroup -Name 'DL-Share-Vertrieb-RW' -SamAccountName 'DL-Share-Vertrieb-RW' `
        -GroupCategory Security -GroupScope DomainLocal `
        -Path $ouGroups `
        -Description 'NTFS Modify auf \\JUMP01\Vertrieb'
}

# 4. Verschachteln: G in DL
Add-ADGroupMember -Identity 'DL-Share-Vertrieb-RW' -Members 'G-Vertrieb' -EA SilentlyContinue

# 5. (P) Permission – Ressource anlegen + ausschließlich an DL berechtigen
$share = 'C:\Shares\Vertrieb'
New-Item -ItemType Directory -Path $share -Force | Out-Null

if (-not (Get-SmbShare -Name 'Vertrieb' -EA SilentlyContinue)) {
    New-SmbShare -Name 'Vertrieb' -Path $share `
        -FullAccess 'Authenticated Users'   # Share-Ebene offen, NTFS regelt
}

# NTFS – nur DL-Gruppe bekommt Modify
$acl = Get-Acl $share
$acl.SetAccessRuleProtection($true, $false)            # Vererbung deaktivieren
$acl.Access | ForEach-Object { $acl.RemoveAccessRule($_) | Out-Null }

$rules = @(
    [System.Security.AccessControl.FileSystemAccessRule]::new(
        'SYSTEM','FullControl','ContainerInherit, ObjectInherit','None','Allow'),
    [System.Security.AccessControl.FileSystemAccessRule]::new(
        'BUILTIN\Administrators','FullControl','ContainerInherit, ObjectInherit','None','Allow'),
    [System.Security.AccessControl.FileSystemAccessRule]::new(
        "$((Get-ADDomain).NetBIOSName)\DL-Share-Vertrieb-RW",
        'Modify','ContainerInherit, ObjectInherit','None','Allow')
)
$rules | ForEach-Object { $acl.AddAccessRule($_) }
Set-Acl -Path $share -AclObject $acl

# 6. Verifikation
Get-Acl $share | Format-List Path, Owner, AccessToString

Write-Host "`nGruppenkette für m.mustermann:" -ForegroundColor Cyan
Get-ADPrincipalGroupMembership -Identity 'm.mustermann' |
    Select-Object Name, GroupCategory, GroupScope |
    Format-Table -AutoSize

Write-Host "`nMitglieder von DL-Share-Vertrieb-RW (rekursiv):" -ForegroundColor Cyan
Get-ADGroupMember -Identity 'DL-Share-Vertrieb-RW' -Recursive |
    Format-Table Name, ObjectClass
