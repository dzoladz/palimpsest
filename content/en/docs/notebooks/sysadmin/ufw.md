---
title: "UFW"
description: >
    Uncomplicated Firewall
---

## Intro

The default firewall configuration tool for Ubuntu is `ufw`. Developed to ease iptables firewall configuration, 
`ufw` provides a user-friendly way to create an IPv4 or IPv6 host-based firewall.

Once a rule is matched the others will **not** be evaluated. Putting the specific rules first and any generic
rules second is expected. As rules change **you may need to delete old rules to ensure that new rules are put 
in the proper order**

Manual: [ufw](https://manpages.ubuntu.com/manpages/noble/en/man8/ufw.8.html)

## Considerations
CISA WAS (Web Application Scanning) IP, ie., do not reject these IPs
https://rules.ncats.cyber.dhs.gov/was.txt

## Common Commands

Enable UFW
```bash
ufw enable
```

Enable Logging
```bash
ufw logging on
```

Check Status
```bash
ufw status
```

Block ALL Incoming Traffic from IP
```bash
ufw deny from <ip address> comment "COMMENT HERE"
```

Allow Incoming TCP Traffic to Port from IP
```bash
ufw allow from <ip address> proto tcp to any port <port number> comment "COMMENT HERE"
```

List Rules by Reference Number
```bash
ufw status numbered
```

Delete a numbered rule
```bash
ufw delete <rule number>
```

## Interpreting Log Entries

```text
Feb  4 23:33:37 hostname kernel: [ 3529.289825] [UFW BLOCK] IN=eth0 OUT= MAC=00:11:22:33:44:55:66:77:88:99:aa:bb:cc:dd 
SRC=444.333.222.111 DST=111.222.333.444 LEN=103 TOS=0x00 PREC=0x00 TTL=52 ID=0 DF PROTO=UDP SPT=53 DPT=36427 LEN=83
```

**Date**
Date of event

**Hostname**
The server’s hostname

**Uptime**
Kernel time since boot.

**Logged Event**
Short description of the logged event: i.e., [UFW BLOCK]

**IN**
If set, the event was an incoming event. Shows the interface from which the packet has arrived.

**OUT**
If set, the event was an outgoing event.

**MAC**
This provides a 14-byte combination of the Destination MAC, Source MAC, and EtherType fields, following 
the order found in the Ethernet II header.

**SRC**
The packet source, or who sent the packet initially.

**DST**
The destination IP, who is meant to receive the packet.

**LEN**
Length of the packet in bytes.

**TOS** (Hex: 0x00, Decimal: 0)
Originally, ToS (Type of Service) field of the IPv4 header. Now, primarily used for Quality of Service
as Differentiated Services Code Point.

**PREC** (Hex: 0x00, Decimal: 0)
The Precedence field of the IPv4 header.

**TTL**
“Time to live” for the packet. Each packet will only bounce through the network until the TTL expires. If the packet
hasn’t found its destination before the TTL expires, it dies and evaporates. This field keeps lost packets from 
clogging the network forever.

**ID**
Unique ID of the IP datagram. This ID will be shared by the fragments of the same packets.

**DF**
The "Do not fragment" flag of TCP

**PROTO**
The protocol of the packet: TCP or UDP.

**SPT**
Indicates the source port.

**DPT**
Indicates the destination port.

**WINDOW**
Indicates the size of packet the sender is willing to receive. TCP

**RES**
This bit is reserved for future use & is always set to 0. (Hex, 0x00)

**SYN URGP**
SYN indicates that this connection requires a three-way handshake, which is typical of TCP connections. 
URGP indicates whether the urgent pointer field is relevant. 0 means it's not.
