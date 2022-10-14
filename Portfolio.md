# Portfolio Windows Server II <!-- omit in toc --> <!--<div style="page-break-after: always;"></div>-->

- [1. De Opstelling](#1-de-opstelling)
  - [1.1. Minimale systeemvereisten](#11-minimale-systeemvereisten)
  - [1.2. Algemene netwerkconfiguratie](#12-algemene-netwerkconfiguratie)
  - [1.3. VM 1: Domain Controller](#13-vm-1-domain-controller)
    - [1.3.1. Configuratie in VirtualBox](#131-configuratie-in-virtualbox)
    - [1.3.2. Rollen](#132-rollen)
  - [1.4. VM 2: Certificate Authority](#14-vm-2-certificate-authority)
    - [1.4.1. Configuratie in VirtualBox](#141-configuratie-in-virtualbox)
    - [1.4.2. Rollen](#142-rollen)
  - [1.5. VM 3: ISS Webserver](#15-vm-3-iss-webserver)
    - [1.5.1. Configuratie in VirtualBox](#151-configuratie-in-virtualbox)
    - [1.5.2. Rollen](#152-rollen)
  - [1.6. VM 3: SQL Server](#16-vm-3-sql-server)
    - [1.6.1. Configuratie in VirtualBox](#161-configuratie-in-virtualbox)
    - [1.6.2. Rollen](#162-rollen)
  - [1.7. VM 4: Exchange](#17-vm-4-exchange)
    - [1.7.1. Configuratie in VirtualBox](#171-configuratie-in-virtualbox)
    - [1.7.2. Rollen](#172-rollen)
  - [1.8. VM 5: Windows Client](#18-vm-5-windows-client)
    - [1.8.1. Configuratie in VirtualBox](#181-configuratie-in-virtualbox)
    - [1.8.2. Rollen](#182-rollen)
  - [1.9. Netwerk Diagram](#19-netwerk-diagram)
- [2. Documentatie van de installatie en configuratie](#2-documentatie-van-de-installatie-en-configuratie)
  - [2.1. Installatie van Windows Server 2019 op VM](#21-installatie-van-windows-server-2019-op-vm)
    - [2.1.1. Desktop Experience](#211-desktop-experience)
    - [2.1.2. Headless (zonder GUI)](#212-headless-zonder-gui)

<div style="page-break-after: always;"></div>

## 1. De Opstelling

### 1.1. Minimale systeemvereisten

- **CPU:** Processor met 12 kernen
- **RAM:** 10 GB
- **Disk:** 150 GB

### 1.2. Algemene netwerkconfiguratie

- **VirtualBox internal network:** 192.168.22.0/24
  - **Server (STATIC) range:** 192.168.22.1 - 192.168.22.100
  - **Client (DHCP) range:** 192.168.22.101 - 192.168.22.150
  - **Closed range:** 192.168.22.150 - 192.168.22.255

### 1.3. VM 1: Domain Controller

#### 1.3.1. Configuratie in VirtualBox

- **Hostname:** EP1-DC
- **OS:** Windows Server 2019 64-bit (Desktop Experience)
- **vCPUs:** 2
- **vRAM:** 3072 MB
- **vDisk:** 40 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** NAT
  - **Adapter 2:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.10

#### 1.3.2. Rollen

- Active Directory
- DNS_1
- DHCP

### 1.4. VM 2: Certificate Authority

#### 1.4.1. Configuratie in VirtualBox

- **Hostname:** EP1-CA
- **OS:** Windows Server 2019 64-bit (Headless)
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 30 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.20

#### 1.4.2. Rollen

- Certificate Authority
- DNS_2

### 1.5. VM 3: ISS Webserver

#### 1.5.1. Configuratie in VirtualBox

- **Hostname:** EP1-WEB
- **OS:** Windows Server 2019 64-bit (Headless)
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 20 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.30

#### 1.5.2. Rollen

- IIS Webserver

### 1.6. VM 3: SQL Server

#### 1.6.1. Configuratie in VirtualBox

- **Hostname:** EP1-DB
- **OS:** SQL Server
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 20 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.40

#### 1.6.2. Rollen

- SQL Database

### 1.7. VM 4: Exchange

#### 1.7.1. Configuratie in VirtualBox

- **Hostname:** EP1-EX
- **OS:** Microsoft Exchange
- **vCPUs:** 2
- **vRAM:** 4096 MB
- **vDisk:** 30 GB (Dynamically allocated)
    <div style="page-break-after: always;"></div>
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.50

#### 1.7.2. Rollen

- Exchange mail server

### 1.8. VM 5: Windows Client

#### 1.8.1. Configuratie in VirtualBox

- **Hostname:** EP1-CLient
- **OS:** Windows 10
- **vCPUs:** 1
- **vRAM:** 2048 MB
- **vDisk:** 30 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** Dynamic (DHCP)

#### 1.8.2. Rollen

- Test machine
- Management tools voor headless servers en database

<div style="page-break-after: always;"></div>

### 1.9. Netwerk Diagram

![diagram](img/Diagrams/EP1_Diagram.png)

<div style="page-break-after: always;"></div>

## 2. Documentatie van de installatie en configuratie

### 2.1. Installatie van Windows Server 2019 op VM

In dit domein wordt er gebruik gemaakt van 3 Virtuele machines waarop Windows Server 2019 draait als besturingssysteem. In het volgende hoofdstuk wordt beschreven hoe men Windows Server installeert op deze VM's. Zowel de Desktop Experience als de Headless installatie worden doorlopen.

#### 2.1.1. Desktop Experience

In bovenstaande opstelling wordt Windows Server 2019 met **Desktop Experience (GUI)** enkel geïnstalleerd op de domeincontroller `EP1-DC`. De installatie op Certificate Authority `EP1-CA` en ISS Webserver `EP1-WEB` betreft een Headless installatie (zonder GUI). De specificaties per VM zijn te vinden in [1. De Opstelling](#1-de-opstelling).

Na het opstarten van de VM met de Windows ISO geladen in het virtueel optisch station krijgen we de mogelijkheid om de taal, tijd en valuta en toetsenbord instellingen aan te passen. Klik op `Volgende` na het kiezen van uw voorkeuren. Klik op `Nu installeren` om de setup te starten. Na het ingeven van de licentiecode verschijnt volgend scherm. Kies hier voor `Bureaubladervaring` en klik `Volgende`.

![setup](img/Inst_WinSer/01.png)

Accepteer vervolgens de licentievoorwaarden en kies voor het installatietype `Aangepast: alleen Windows installeren (geavanceerd)`. Zo zal er een verse installatie van Windows uitgevoerd worden op onze VM.

Het volgende scherm betreft de partities aanmaken op onze virtuele harde schijf. Momenteel zijn er nog geen partities aangemaakt en is alle ruimte op de virtuele harde schijf nog niet toegewezen. Selecteer de ruimte van het station en klik op `Nieuw`. Ik kies in dit geval om de volledige schijf toe te kennen aan 1 partitie. Windows creëert automatisch een partitie dat gereserveerd is voor het systeem. Als er later een extra partitie nodig zou zijn, kunnen we deze nog aanmaken in Windows zelf.

![setup](img/Inst_WinSer/02.png)

Klik op `Volgende`. De setup begint nu met het installeren van Windows. Dit kan enige tijd in beslag nemen. Na het kiezen van een wachtwoord voor de Administrator gebruiker belanden we op het loginscherm. De installatie is nu voltooid. 

Binnen de context van dit domein koos ik er ook voor om Windows Updates uit te schakelen op alle servers door de `Update Orchestrator Service` te stoppen. Updates kunnen namelijk een groot deel resources gebruiken, tijdelijk de server onbereikbaar maken en ze zijn bovendien niet noodzakelijk binnen deze opdracht.

#### 2.1.2. Headless (zonder GUI)

De headless installatie verloopt redelijk analoog met de desktop experience.