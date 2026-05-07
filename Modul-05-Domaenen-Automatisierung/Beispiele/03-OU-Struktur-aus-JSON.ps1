<#
.SYNOPSIS
    Trainer-Demo: OU-Struktur aus JSON aufbauen (idempotent, rekursiv).

.EXAMPLE
    .\03-OU-Struktur-aus-JSON.ps1 -JsonPath .\OU-Struktur.json
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)] [string] $JsonPath
)

Import-Module ActiveDirectory

function New-OuRecursive {
    param(
        [Parameter(Mandatory)] $Node,
        [Parameter(Mandatory)] [string] $ParentDN
    )

    $dn = "OU=$($Node.Name),$ParentDN"
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$dn'" -EA SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $Node.Name -Path $ParentDN `
            -Description ($Node.Description ?? '') `
            -ProtectedFromAccidentalDeletion $true
        Write-Host "  + $dn" -ForegroundColor Green
    } else {
        Write-Host "  = $dn (existiert)" -ForegroundColor DarkGray
    }

    foreach ($child in @($Node.Children)) {
        if ($child) { New-OuRecursive -Node $child -ParentDN $dn }
    }
}

$tree     = Get-Content $JsonPath -Raw -Encoding UTF8 | ConvertFrom-Json
$domainDN = (Get-ADDomain).DistinguishedName

foreach ($root in @($tree)) {
    New-OuRecursive -Node $root -ParentDN $domainDN
}
