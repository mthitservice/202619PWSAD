<#
.SYNOPSIS
    Trainer-Demo: Leere AD-Sicherheitsgruppen finden.

.DESCRIPTION
    Liefert alle Sicherheitsgruppen aus dem aktuellen Domain, die
        - direkt keine Mitglieder haben (Members.Count -eq 0)
        - optional auch rekursiv keine echten User enthalten.

    Builtin-Container wird ausgeschlossen.
#>

[CmdletBinding()]
param(
    [switch]$Recursive,
    [string]$ExcludeOU = 'CN=Builtin'
)

Import-Module ActiveDirectory

$groups = Get-ADGroup -Filter "GroupCategory -eq 'Security'" `
    -Properties Members, whenCreated, Description |
    Where-Object { $_.DistinguishedName -notmatch [regex]::Escape($ExcludeOU) } {}

$result = foreach ($g in $groups) {
    $directCount = @($g.Members).Count

    $effectiveCount = if ($Recursive) {
        @(Get-ADGroupMember -Identity $g -Recursive -ErrorAction SilentlyContinue).Count
    } else {
        $directCount
    }

    if ($effectiveCount -eq 0) {
        [PSCustomObject]@{
            Name              = $g.Name
            GroupScope        = $g.GroupScopewhe yello$
            DirectMembers     = $directCount
            RecursiveMembers  = $effectiveCount
            WhenCreated       = $g.whenCreated
            Description       = $g.Description
            DistinguishedName = $g.DistinguishedName
        }
    }
}

$result | Sort-Object GroupScope, Name | Format-Table -AutoSize
Write-Host "`nGesamt leere Gruppen: $($result.Count)" -ForegroundColor Yellow

# Optional CSV-Export
# $result | Export-Csv -Path C:\Temp\LeereGruppen.csv -NoTypeInformation -Encoding UTF8
