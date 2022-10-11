# Windows Server II

## Algemene netwerkconfiguratie

- **VirtualBox internal network:** 192.168.22.0/24
  - **Server (STATIC) range:** 192.168.22.1 - 192.168.22.100
  - **Client (DHCP) range:** 192.168.22.101 - 192.168.22.150
  - **Closed range:** 192.168.22.150 - 192.168.22.255

## VM 1: Domain Controller

### Configuratie in VirtualBox

- **Hostname:** EP1-DC
- **OS:** Windows Server 2019 64-bit (Desktop Experience)
- **vCPUs:** 2
- **vRAM:** 2048 MB
- **vDisk:** 40 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** NAT
  - **Adapter 2:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.10

### Rollen

- Active Directory
- DNS_1
- DHCP

## VM 2: Certificate Authority

### Configuratie in VirtualBox

- **Hostname:** EP1-CA
- **OS:** Windows Server 2019 64-bit (Headless)
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 20 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.20

### Rollen

- Certificate Authority

<div style="page-break-after: always;"></div>

## VM 3: ISS Webserver

### Configuratie in VirtualBox

- **Hostname:** EP1-WEB
- **OS:** Windows Server 2019 64-bit (Headless)
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 20 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.30

### Rollen

- IIS Webserver

## VM 3: SQL Server

### Configuratie in VirtualBox

- **Hostname:** EP1-DB
- **OS:** SQL Server
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 20 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.40

### Rollen

- SQL Database

## VM 4: Exchange

### Configuratie in VirtualBox

- **Hostname:** EP1-EX
- **OS:** Microsoft Exchange
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 20 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.50

<div style="page-break-after: always;"></div>

## Netwerk Diagram

![diagram](img/Diagrams/EP1_Diagram.png)
