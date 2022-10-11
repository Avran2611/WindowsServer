# Windows Server II <!-- omit in toc -->

- [1. Minimale systeemvereisten](#1-minimale-systeemvereisten)
- [2. Algemene netwerkconfiguratie](#2-algemene-netwerkconfiguratie)
- [3. VM 1: Domain Controller](#3-vm-1-domain-controller)
  - [3.1. Configuratie in VirtualBox](#31-configuratie-in-virtualbox)
  - [3.2. Rollen](#32-rollen)
- [4. VM 2: Certificate Authority](#4-vm-2-certificate-authority)
  - [4.1. Configuratie in VirtualBox](#41-configuratie-in-virtualbox)
  - [4.2. Rollen](#42-rollen)
- [5. VM 3: ISS Webserver](#5-vm-3-iss-webserver)
  - [5.1. Configuratie in VirtualBox](#51-configuratie-in-virtualbox)
  - [5.2. Rollen](#52-rollen)
- [6. VM 3: SQL Server](#6-vm-3-sql-server)
  - [6.1. Configuratie in VirtualBox](#61-configuratie-in-virtualbox)
  - [6.2. Rollen](#62-rollen)
- [7. VM 4: Exchange](#7-vm-4-exchange)
  - [7.1. Configuratie in VirtualBox](#71-configuratie-in-virtualbox)
  - [7.2. Rollen](#72-rollen)
- [8. VM 5: Windows Client](#8-vm-5-windows-client)
  - [8.1. Configuratie in VirtualBox](#81-configuratie-in-virtualbox)
  - [8.2. Rollen](#82-rollen)
- [9. Netwerk Diagram](#9-netwerk-diagram)

<div style="page-break-after: always;"></div>

## 1. Minimale systeemvereisten
  - **CPU:** Processor met 12 kernen
  - **RAM:** 10 GB
  - **Disk:** 150 GB

## 2. Algemene netwerkconfiguratie

- **VirtualBox internal network:** 192.168.22.0/24
  - **Server (STATIC) range:** 192.168.22.1 - 192.168.22.100
  - **Client (DHCP) range:** 192.168.22.101 - 192.168.22.150
  - **Closed range:** 192.168.22.150 - 192.168.22.255

## 3. VM 1: Domain Controller

### 3.1. Configuratie in VirtualBox

- **Hostname:** EP1-DC
- **OS:** Windows Server 2019 64-bit (Desktop Experience)
- **vCPUs:** 2
- **vRAM:** 3072 MB
- **vDisk:** 40 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** NAT
  - **Adapter 2:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.10

### 3.2. Rollen

- Active Directory
- DNS_1
- DHCP

## 4. VM 2: Certificate Authority

### 4.1. Configuratie in VirtualBox

- **Hostname:** EP1-CA
- **OS:** Windows Server 2019 64-bit (Headless)
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 30 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.20

<div style="page-break-after: always;"></div>

### 4.2. Rollen

- Certificate Authority
- DNS_2

## 5. VM 3: ISS Webserver

### 5.1. Configuratie in VirtualBox

- **Hostname:** EP1-WEB
- **OS:** Windows Server 2019 64-bit (Headless)
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 20 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.30

### 5.2. Rollen

- IIS Webserver

## 6. VM 3: SQL Server

### 6.1. Configuratie in VirtualBox

- **Hostname:** EP1-DB
- **OS:** SQL Server
- **vCPUs:** 1
- **vRAM:** 1024 MB
- **vDisk:** 20 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.40

### 6.2. Rollen

- SQL Database

<div style="page-break-after: always;"></div>

## 7. VM 4: Exchange

### 7.1. Configuratie in VirtualBox

- **Hostname:** EP1-EX
- **OS:** Microsoft Exchange
- **vCPUs:** 2
- **vRAM:** 4096 MB
- **vDisk:** 30 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** 192.168.22.50

### 7.2. Rollen

  - Exchange mail server

<!--<div style="page-break-after: always;"></div>-->
## 8. VM 5: Windows Client

### 8.1. Configuratie in VirtualBox

- **Hostname:** EP1-CLient
- **OS:** Windows 10
- **vCPUs:** 1
- **vRAM:** 2048 MB
- **vDisk:** 30 GB (Dynamically allocated)
- **Network:**
  - **Adapter 1:** Intern netwerk (winnet)
    - **IP adres:** Dynamic (DHCP)

### 8.2. Rollen

  - Test machine
  - Management tools voor headless servers en database

<div style="page-break-after: always;"></div>

## 9. Netwerk Diagram

![diagram](img/Diagrams/EP1_Diagram.png)
