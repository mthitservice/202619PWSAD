<#
.SYNOPSIS
    Trainer-Demo: Zusätzlichen DC zur bestehenden Domäne hinzufügen.

.DESCRIPTION
    Wird auf einer Member-Server-VM ausgeführt, die der Domäne ITH-01.local
    bereits beigetreten ist.
#>

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Install-ADDSDomainController `
    -DomainName       'ITH-01.local' `
    -InstallDns:$true `
    -SiteName         'Dresden' `
    -DatabasePath     'C:\Windows\NTDS' `
    -LogPath          'C:\Windows\NTDS' `
    -SysvolPath       'C:\Windows\SYSVOL' `
    -Credential       (Get-Credential 'ITH-01\Administrator') `
    -SafeModeAdministratorPassword (Read-Host 'DSRM-Passwort (Lab: Pa$$w0rd202619)' -AsSecureString) `
    -NoRebootOnCompletion:$false `
    -Force
