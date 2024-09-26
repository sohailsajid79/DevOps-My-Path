# Networking Fundamentals

1. [OSI Model Overview](#osi-model-overview)

   - [Application](#application)
   - [Presentation](#presentation)
   - [Session](#session)
   - [Transport](#transport)
   - [Network](#network)
     - [IP Addressing](#ip-addressing)
     - [Subnetting](#subnetting)
     - [NAT](#nat)
   - [Data Link](#data-link)
   - [Physical](#physical)

2. [TCP/IP Model](#tcpip-model)
3. [DNS](#dns)
   - [DNS Resolution Process](#dns-resolution-process)
   - [Common DNS Records](#common-dns-records)
   - [DNS Troubleshooting Tools](#dns-troubleshooting-tools)
4. [Common Ports](#common-ports)

## OSI Model Overview

### Application

The Application Layer is the top layer of the OSI model. It interacts directly with end-user applications and provides the interface for users to communicate with the network. This layer handles network services that end-users interact with, such as web browsing, file transfers, and email.

- **Protocols**: HTTP/HTTPS, SSH, DNS

### Presentation

Responsible for data translation and syntax, ensuring the format and structure of the data are standardised, so it can be understood across different systems.

For example, converting ASCII to UTF-8 or preparing data for encryption or compression. Syntax on the other hand ensures that the data being transmitted follows the agreed-upon rules for representation, such as encoding formats or data types; **JSON**, **XML** or **YAML**.

The presentation layer also handles data encryption and decryption, like SSL/TLS, for secure communication between the client and server.

- **Protocols**: SSL/TLS, SSH, IMAP, FTP

### Session

**Responsible for establishing, managing, and terminating sessions between two communicating systems**. For example, it manages authentication flows like **OAuth**, which defines the steps an application follows to verify a user's identity (authentication). The flow determines how tokens are issued, exchanged, and used to securely authenticate users without directly sharing sensitive credentials, such as passwords.

### Transport

Handles end-to-end communication and is responsible for the delivery of data packets and ensuring that data is sent and received correctly across a network.

- **Protocols**:

  - TCP

    - Before any data is transmitted, TCP establishes a connection between the sender and receiver using a **three-way handshake** (SYN, SYN-ACK, ACK).
    - **End-to-end reliability**: TCP ensures that all data packets are received in the correct order and without errors. If packets are lost, TCP handles re-transmission.
    - **Error-checking and flow control**: TCP ensures the integrity of data through error-checking mechanisms like checksums, and it manages the rate at which data is sent to avoid overwhelming the receiver.
    - **Use case**: We use TCP when accuracy and complete data transfer are crucial, such as web browsing (HTTP/HTTPS), file transfers (FTP), and email (SMTP).

  - **UDP**
    - Unreliable, connectionless protocol and unlike TCP, UDP does not establish a connection before sending data. It simply sends data as packets, called datagrams, without checking whether they are received correctly.
    - **Fast but less reliable**: Since there is no connection setup or error-checking, UDP is much faster than TCP. However, there's no guarantee that all packets will arrive, or that they will arrive in order.
    - **Use case**: We use UDP when speed is more important than reliability. It’s often used for real-time applications such as live streaming, online gaming, and voice/video calls, where small amounts of data loss are acceptable.

### Network

**Deals with logical addressing and routing traffic between different networks using IP addresses**.\*

**Routers** - Commonly referred to as the **default gateway**, routers route traffic between networks based on IP addresses. For example, a router connects your home network (LAN) to the internet (WAN) and can optionally connect via WiFi or Ethernet cable.

**Switches** - On the other hand, switches provide connectivity within a Local Area Network (LAN). They forward traffic from one port to another based on MAC addresses.

#### IP Addressing

IPv4: sliced into network | host

- 4 groups of 8 bits (octets) for a total of 32-bits e.g. `192.168.1.1`

IPv6: next gen

- 8 groups of 4x hexadecimal digits totaling 128-bit e.g. `2001:0db8:85a3:0000:0000:8a2e:0370:7334`
- Compressed version: `2001:db8:85a3::8a2e:370:7334`

#### Subnetting

Subnetting divides a large network into smaller sub-networks (subnets) to helps manage IP address allocation more efficiently and controls network traffic.

Analogy 🥳 - think of subnetting like cutting a large birthday cake into smaller slices so everyone at the party can have a piece.

**Cake 🎂**: The cake represents the large network, and everyone at the party (users/devices) needs a slice (IP address) from it.

**Cutting the Cake 🔪**: Just as you divide the cake into equal-sized slices, subnetting divides the larger network (the cake) into smaller subnets, each with a portion of the IP addresses.

**Slices 🍰**: Each slice of cake represents a subnet. Each subnet has its own defined number of IP addresses, just like each slice has a certain size. You can make smaller or larger slices based on how many guests (devices) need to be accommodated in each subnet.

**Efficient Distribution 🧳**: If you don’t cut the cake (subnet), some guests might get too much cake, and some might get none. Similarly, without subnetting, IP addresses might be inefficiently used, with some parts of the network overcrowded and others underutilised.

**Controlling Traffic 🚦**: By organising the cake into slices, you ensure that each guest stays in their area and doesn't take extra cake from other slices, just like subnets control network traffic within their own space to prevent congestion.

In both cases, subnetting (cutting the cake) helps distribute resources efficiently and ensure everyone gets their share.

An IP address `192.168.1.0` with a default subnet mask `255.255.255.0`:

- The first three octets (`255.255.255`) represent the network part. The last octet (0) represents the host part. The CIDR notation for this would be `192.168.1.0/24`.

- The /24 subnet mask in binary is:
  `11111111.11111111.11111111.00000000` - the first 24 bits are for the network, the remaining 8 bits are for the host.

#### NAT

NAT (Network Address Translation) operates at Layer 3 as well, since it involves IP address manipulation to route traffic between a local network (with private IPs) and the internet (with public IPs).

- **Private IPs**: Devices within a local network (e.g. 192.168.1.x) use private IP addresses that are not routable on the internet.
- **Public IP**: When these devices access the internet, the router uses NAT to translate the private IP address into a single public IP address.
- **Traffic Translation**: The router keeps track of which internal devices requested what external resources, ensuring that responses from the internet are sent back to the correct device.

Types of NAT:

- **Static NAT**: Maps one private IP to one public IP.
- **Dynamic NAT**: Maps multiple private IPs to a pool of public IPs.
- **PAT (Port Address Translation)**: A form of NAT that maps multiple private IPs to a single public IP, using different ports.

### Data Link

**Responsible for node-to-node data transfer.**

**MAC Address**: A unique identifier assigned to a network interface card and every device on a local network has a unique MAC address.

**Framing**: The data is encapsulated into frames, which include a header and a payload. The header contains the source and destination MAC addresses, as well as other control information like error-checking mechanisms (e.g. CRC). The payload contains the actual data being transmitted between devices.

### Physical

Responsible for the physical transmission of data over network mediums: electrical | optical | radio signals

Components of the Physical Layer:

- **Fiber**: Transmits data as light pulses through fiber-optic cables.
- **Wireless**: Transmits data as radio waves (e.g. Wi-Fi, Bluetooth).
- **Hubs**: Basic network devices that broadcast data to all devices in a local network without filtering or routing.
- **Repeaters**: Amplify or regenerate signals to extend the transmission distance over a network medium, ensuring that the signal remains strong over long distances.

## TCP/IP Model

### Application

Corresponds to Layers 5, 6, and 7 of the OSI Model:

- This layer handles high-level protocols and is where network applications operate (such as web browsers or email clients). It provides an interface between the user and the network, allowing applications to communicate with each other over the internet.

Protocols:

- HTTP/HTTPS: Web browsing
- FTP: File transfer
- SMTP: Email
- DNS: Domain name resolution

### Transport

Corresponds to Layer 4 of the OSI Model:

- This layer ensures end-to-end communication between devices, handling control flow, and error checking of data. It manages how data is reliably or unreliably transmitted between devices.

Protocols:

- TCP
- UDP

### Internet

Corresponds to Layer 3 (Network Layer) of the OSI Model:
This layer is responsible for routing packets across different networks using IP addresses. It ensures that packets are forwarded between devices and across networks until they reach their destination.

Protocols:

- IP
- ICMP: `ping` `tracert` (Windows) `traceroute` (Linux/Mac)

### Network Access

Corresponds to Layers 1 and 2 of the OSI Model (Physical and Data Link):

- This layer is responsible for how data is physically transmitted across the network medium; Ethernet cables or Wi-Fi. It includes framing, physical addressin, and handling the actual transmission of data bits over network hardware.

Protocols:

- Ethernet: Standard for wired LAN communication.
- Wi-Fi (IEEE 802.11): Standard for wireless LAN communication.

## DNS

DNS translates human-readable domain names (e.g. google.com) to IP address (e.g. 8.8.8.8), which enables devices to find and connect to websites and services on the internet.

### DNS Resolution Process

1. User enters a URL (e.g. [www.footballfantasy.com](https://fantasy.premierleague.com/)).
   The DNS resolver **checks the local cache**. If no cached record exists:
2. The DNS resolver queries a **Root Nameserver**, which directs the request to the appropriate TLD (Top-Level Domain) Nameserver (e.g. .com).
3. The **TLD Nameserver** directs the request to the Authoritative Nameserver, which contains the domain’s DNS records.
4. The **Authoritative Nameserver** returns the IP address associated with the domain.
5. The DNS resolver caches the IP address for future use.

### Common DNS Records

- `A`: Maps a domain to an IPv4 address.
- `AAAA`: Maps a domain to an IPv6 address.
- `CNAME`: Alias record that points one domain to another (e.g. www.footballfantasy.com to footballfantasy.com).
- `MX`: Specifies the mail server responsible for receiving emails for the domain.
- `TXT`: Allows administrators to insert text, commonly used for domain verification and other configurations.

### DNS Troubleshooting Tools

- `dig`: query DNS name servers and display DNS records:

```
dig ns footballfantasy.com
```

```
dig +short ns footballfantasy.com
```

- `nslookup`: query DNS records and resolving hostnames to IP addresses:

```
nslookup footballfantasy.com
```

- `ping`: sends requests to domain name/ IP address to check network connectivity and response time.

```
ping footballfantasy.com
```

- `/etc/hosts file`: contains local mappings between hostnames and IP addresses for quick lookup.

- `ipconfig` (Windows): displays network configurations

- `ipconfig /flushdns`: if experiencing problems with websites not loading, or if DNS records have changed we can clear the cache to get fresh DNS information.

- `ipconfig /release`: when we need to drop the current network configuration to force a new IP address lease from the DHCP server.

- `ipconfig /renew`: after releasing the IP address with ipconfig /release, we need to renew the request for a new IP address from the DHCP server.

## Common Ports

| Port Number | Protocol   | Description                                                 |
| ----------- | ---------- | ----------------------------------------------------------- |
| 20          | FTP        | File Transfer Protocol (data transfer)                      |
| 21          | FTP        | File Transfer Protocol (command/control)                    |
| 22          | SSH        | Secure Shell (secure remote login)                          |
| 23          | Telnet     | Unencrypted remote login                                    |
| 25          | SMTP       | Simple Mail Transfer Protocol (email sending)               |
| 53          | DNS        | Domain Name System (name resolution)                        |
| 67/68       | DHCP       | Dynamic Host Configuration Protocol (IP address assignment) |
| 80          | HTTP       | Hypertext Transfer Protocol (web browsing)                  |
| 110         | POP3       | Post Office Protocol (retrieving email)                     |
| 143         | IMAP       | Internet Message Access Protocol (retrieving email)         |
| 443         | HTTPS      | Hypertext Transfer Protocol Secure (secure web browsing)    |
| 445         | SMB        | Server Message Block (file sharing in Windows)              |
| 3389        | RDP        | Remote Desktop Protocol (remote desktop)                    |
| 389         | LDAP       | Lightweight Directory Access Protocol (directory services)  |
| 636         | LDAPS      | Secure LDAP (encrypted directory services)                  |
| 137-139     | NetBIOS    | NetBIOS services over TCP/IP (older file sharing)           |
| 161/162     | SNMP       | Simple Network Management Protocol (network management)     |
| 69          | TFTP       | Trivial File Transfer Protocol (simple, no authentication)  |
| 2049        | NFS        | Network File System (file sharing in Unix/Linux)            |
| 3306        | MySQL      | MySQL database server                                       |
| 5432        | PostgreSQL | PostgreSQL database server                                  |
| 8080        | HTTP       | Alternative HTTP port (used for testing/development)        |
| 5900        | VNC        | Virtual Network Computing (remote desktop sharing)          |
