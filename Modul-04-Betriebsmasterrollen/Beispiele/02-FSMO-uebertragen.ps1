<#
.SYNOPSIS
    Trainer-Demo: FSMO-Rollen übertragen.

.DESCRIPTION
    Überträgt PDC-Emulator und RID-Master von DC01 auf DC02.
    Voraussetzung: DC02 ist als Domain Controller installiert
    (siehe Modul 05).
#>

Import-Module ActiveDirectory

# Ziel-DC, der die Rollen übernehmen soll
$target = 'DC02'

Move-ADDirectoryServerOperationMasterRole `
    -Identity $target `
    -OperationMasterRole PDCEmulator, RIDMaster `
    -Confirm:$false

# Verifizieren
Get-ADDomain | Select-Object PDCEmulator, RIDMaster
