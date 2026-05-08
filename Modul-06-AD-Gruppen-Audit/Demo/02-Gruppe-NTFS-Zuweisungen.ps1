<#
.SYNOPSIS
    Trainer-Demo: Alle Ordner finden, auf denen eine AD-Gruppe per NTFS
    berechtigt ist – inkl. Share-Ebene.

.DESCRIPTION
    Durchsucht angegebene Wurzelpfade rekursiv und prüft je Ordner die
    NTFS-ACL. Optional werden zusätzlich die SMB-Shares auf dem lokalen
    Fileserver durchleuchtet.

.PARAMETER GroupName
    sAMAccountName oder Anzeigename der gesuchten AD-Gruppe.
    Vergleich erfolgt unabhängig von der Domäne (NetBIOS\Name oder Name).

.PARAMETER Roots
    Eine oder mehrere Pfade, in denen rekursiv gesucht werden soll.
    Standard: alle lokalen SMB-Share-Pfade.

.PARAMETER IncludeShares
    Zusätzlich Share-Permissions (Get-SmbShareAccess) prüfen.

.EXAMPLE
    .\02-Gruppe-NTFS-Zuweisungen.ps1 -GroupName 'DL-Share-Vertrieb-RW' -IncludeShares

.NOTES
    Auf dem Fileserver (z. B. JUMP01) als Admin ausführen.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$GroupName,

    [string[]]$Roots,

    [switch]$IncludeShares
)

# 1. Wurzeln bestimmen – wenn nicht übergeben, alle Shares
if (-not $Roots) {
    $Roots = Get-SmbShare |
        Where-Object { $_.Path -and $_.Name -notin 'ADMIN$','IPC$','C$','D$','print$' } |
        Select-Object -ExpandProperty Path -Unique
}

if (-not $Roots) {
    Write-Warning 'Keine Wurzelpfade gefunden – bitte -Roots angeben.'
    return
}

Write-Host "Suche nach Gruppe '$GroupName' in:" -ForegroundColor Cyan
$Roots | ForEach-Object { Write-Host "  $_" }

# 2. NTFS-Auswertung
$ntfsResult = foreach ($root in $Roots) {
    if (-not (Test-Path $root)) { continue }

    Get-ChildItem -Path $root -Directory -Recurse -Force -ErrorAction SilentlyContinue |
        ForEach-Object {
            try {
                $acl = Get-Acl -LiteralPath $_.FullName -ErrorAction Stop
            } catch { return }

            foreach ($rule in $acl.Access) {
                $id = $rule.IdentityReference.Value
                if ($id -match "(^|\\)$([regex]::Escape($GroupName))$") {
                    [PSCustomObject]@{
                        Source     = 'NTFS'
                        Path       = $_.FullName
                        Identity   = $id
                        Rights     = $rule.FileSystemRights
                        Type       = $rule.AccessControlType
                        Inherited  = $rule.IsInherited
                    }
                }
            }
        }

    # Wurzel selbst auch prüfen
    try {
        $aclRoot = Get-Acl -LiteralPath $root
        foreach ($rule in $aclRoot.Access) {
            if ($rule.IdentityReference.Value -match "(^|\\)$([regex]::Escape($GroupName))$") {
                [PSCustomObject]@{
                    Source     = 'NTFS'
                    Path       = $root
                    Identity   = $rule.IdentityReference.Value
                    Rights     = $rule.FileSystemRights
                    Type       = $rule.AccessControlType
                    Inherited  = $rule.IsInherited
                }
            }
        }
    } catch {}
}

# 3. Optional: Share-Ebene
$shareResult = if ($IncludeShares) {
    Get-SmbShare | ForEach-Object {
        $share = $_
        Get-SmbShareAccess -Name $share.Name -ErrorAction SilentlyContinue |
            Where-Object { $_.AccountName -match "(^|\\)$([regex]::Escape($GroupName))$" } |
            ForEach-Object {
                [PSCustomObject]@{
                    Source     = 'Share'
                    Path       = "\\$env:COMPUTERNAME\$($share.Name)"
                    Identity   = $_.AccountName
                    Rights     = $_.AccessRight
                    Type       = $_.AccessControlType
                    Inherited  = $false
                }
            }
    }
}

$all = @($ntfsResult) + @($shareResult)
$all | Sort-Object Source, Path | Format-Table -AutoSize
Write-Host "`nGesamt-Treffer: $($all.Count)" -ForegroundColor Yellow
