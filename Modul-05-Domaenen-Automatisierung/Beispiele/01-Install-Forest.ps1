<#
.SYNOPSIS
    Trainer-Demo: Neue Gesamtstruktur installieren.

.DESCRIPTION
    Wird auf einem frisch installierten Server (Core oder Desktop) ausgeführt.
    Voraussetzung: Statische IP, Hostname gesetzt, kein Domain-Member.
#>

# Rolle installieren
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Forest installieren
Install-ADDSForest `
    -DomainName            'ITH-01.local' `
    -DomainNetbiosName     'ITH-01' `
    -ForestMode            'WinThreshold' `
    -DomainMode            'WinThreshold' `
    -InstallDns:$true `
    -DatabasePath          'C:\Windows\NTDS' `
    -LogPath               'C:\Windows\NTDS' `
    -SysvolPath            'C:\Windows\SYSVOL' `
    -SafeModeAdministratorPassword (Read-Host 'DSRM-Passwort (Lab: Pa$$w0rd202619)' -AsSecureString) `
    -NoRebootOnCompletion:$false `
    -Force
