<#
.SYNOPSIS
    Trainer-Demo: Computer-Konto vorab im AD anlegen ("pre-stage").

.DESCRIPTION
    Pre-staging legt das Computerkonto in der gewünschten OU an, BEVOR
    das System der Domäne beitritt. So greifen die richtigen GPOs sofort.
#>

Import-Module ActiveDirectory

$ouComputers = "OU=Computer,OU=PWSAD,$((Get-ADDomain).DistinguishedName)"

New-ADComputer -Name 'MEM01' -SamAccountName 'MEM01$' `
    -Path $ouComputers `
    -Enabled $true `
    -Description 'Übungs-Member-Server'

Get-ADComputer -Identity 'MEM01' -Properties Description, OperatingSystem |
    Format-List Name, DistinguishedName, Description, OperatingSystem, Enabled
