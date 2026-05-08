<#
.SYNOPSIS
    Trainer-Demo: FSMO-Rollen anzeigen.
#>

Import-Module ActiveDirectory

$forest = Get-ADForest
$domain = Get-ADDomain

[PSCustomObject]@{
    SchemaMaster         = $forest.SchemaMaster
    DomainNamingMaster   = $forest.DomainNamingMaster
    PDCEmulator          = $domain.PDCEmulator
    RIDMaster            = $domain.RIDMaster
    InfrastructureMaster = $domain.InfrastructureMaster
} | Format-List

# Alternative: netdom (klassisch)
# netdom query fsmo
