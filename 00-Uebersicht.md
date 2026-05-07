# Lab-Setup – Übersicht

Wird gemeinsam mit den Teilnehmern aufgebaut.

## Hardware / Hyper-V

- Host: Hyper-V (Windows 11 Pro / Server 2022+)
- Virtuelle Switches:
  - **`ITH Internes Netz`** – Typ *intern*. Trägt das gesamte Lab (`10.10.0.0/24`).
    Alle VMs hängen primär hier.
  - **`Default Switch`** (oder ein eigener *externer* Switch) – nur für die
    **zweite NIC von JUMP01**, um bei Bedarf temporär Internet zu haben
    (z. B. für `winget` / Updates). NIC standardmäßig **deaktiviert** lassen.
- IP-Bereich Lab: `10.10.0.0/24`
  - DC01: `10.10.0.10`
  - JUMP01: `10.10.0.20`
  - Reserve Übungs-VMs: `10.10.0.30 – 10.10.0.99`

Switch anlegen (PowerShell auf dem Hyper-V-Host):

```powershell
New-VMSwitch -Name 'ITH Internes Netz' -SwitchType Internal
# Adapter auf dem Host umbenennen / IP setzen ist NICHT nötig,
# der Host braucht keinen Zugriff ins Lab-Netz.
```

## VMs

| Name    | OS                              | Rolle                | RAM   | Disk  |
|---------|---------------------------------|----------------------|-------|-------|
| DC01    | Windows Server 2025 **Core**    | AD DS, DNS, DHCP opt | 2 GB  | 60 GB |
| JUMP01  | Windows Server 2025 Desktop Exp | Verwaltung, RSAT     | 4 GB  | 80 GB |
| MEM01+  | Win Server 2025 / Win 11        | Übungs-Member        | 2 GB  | 40 GB |

## Domäne

- Forest / Domäne: `ITH-xx.local` (xx = Teilnehmernummer 01..03)
- NetBIOS: `ITH-xx`
- Site: `Dresden`

## Passwörter (Lab-Konvention)

> Nur für die Trainingsumgebung. Nicht produktiv verwenden.

| Verwendung                                                              | Passwort           |
|-------------------------------------------------------------------------|--------------------|
| Lokaler Administrator (DC-Core vor Promotion, JUMP01, Member-VMs), DSRM | <code>Pa&#36;&#36;w0rd202619</code> |
| Domain-Konten (Domain-Admin, Demo-/Übungs-User, Resets)                 | `Pa55w.rd2619`     |

## Reihenfolge der Vorbereitung

1. Hyper-V Switch `ITH Internes Netz` anlegen
2. DC01 (Core) installieren – siehe [01-DC-Core-Install.md](01-DC-Core-Install.md)
3. Forest installieren
4. JUMP01 installieren (mit zwei NICs) – siehe [02-Jumpserver-Install.md](02-Jumpserver-Install.md)
5. JUMP01 in Domäne aufnehmen
6. RSAT auf JUMP01
7. GPOs für Core-Verwaltung – siehe [03-GPOs-Core-Verwaltung.md](03-GPOs-Core-Verwaltung.md)

## GPO-Anforderungen für Core-Verwaltung

Damit DC01 (Core, ohne GUI) komfortabel von JUMP01 administriert werden kann:

- WinRM aktivieren (Listener HTTP)
- Firewall-Ausnahmen: WinRM, RDP, Remote-Eventlog, Remote-Volumeverwaltung,
  Remote-Dienstverwaltung, MMC-Snap-Ins
- PowerShell-Remoting: TrustedHosts (nur bis Domain-Join nötig)
- ExecutionPolicy für Trainings-Skripte: `RemoteSigned`
- PowerShell Script Block Logging aktivieren (Demo / Best Practice)
