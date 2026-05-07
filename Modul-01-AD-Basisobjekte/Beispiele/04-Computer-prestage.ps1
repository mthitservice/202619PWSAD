<#
.SYNOPSIS
    Übungs-Stub: Computer-Konto vorab im AD anlegen ("pre-stage").

.DESCRIPTION
    Wird in der Live-Demo gemeinsam erarbeitet.
    Ziel: Computer-Objekt in OU=Computer,OU=PWSAD anlegen, damit beim
    Domänenbeitritt die richtigen GPOs sofort greifen.
#>

Import-Module ActiveDirectory

# TODO: OU-Pfad bestimmen
# TODO: New-ADComputer mit -SamAccountName 'NAME$'
# TODO: Get-ADComputer -Properties Description, OperatingSystem
