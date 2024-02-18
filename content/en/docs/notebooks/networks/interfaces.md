---
title: "Interfaces"
description: >
    Network Interfaces
---

```shell
root@proxmox:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute
       valid_lft forever preferred_lft forever
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master vmbr0 state UP group default qlen 1000
    link/ether 78:2b:cb:5a:13:8a brd ff:ff:ff:ff:ff:ff
    altname enp1s0f0
3: eno2: <BROADCAST,MULTICAST> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 78:2b:cb:5a:13:8b brd ff:ff:ff:ff:ff:ff
    altname enp1s0f1
5: vmbr0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 78:2b:cb:5a:13:8a brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.20/24 scope global vmbr0
       valid_lft forever preferred_lft forever
    inet6 fe80::7a2b:cbff:fe5a:138a/64 scope link
       valid_lft forever preferred_lft forever
```

## Interface Details

### Physical Layer - Layer 1

- **eno1**
  - The name of the interface from the operating system’s perspective. This depends a lot on the specific distribution of Linux you are running, whether it is a virtual or physical machine, and the type of interface.
- **<BROADCAST,MULTICAST,UP,LOWER_UP>**
  - A series of flags that provide details about the interface state. This shows that my interface is both broadcast and multicast capable and that the interface is enabled (UP) and that the physical layer is connected (LOWER_UP).
- **mtu 1500**
  - Maximum transmission unit (MTU), in bytes, for the interface.
- **qdisc mq**
  - Queueing approach being used by the interface: “noqueue” (send immediately) or “noop” (drop all).
- **state UP**
  - Operational state of an interface. “UP”, “DOWN”, and “UNKNOWN”. “UNKNOWN” indicates that the interface is up and operational, but nothing is connected.
- **group default**
  - Interfaces can be grouped together on Linux to allow common attributes or commands. Having all interfaces connected to “group default” is the most common setup.
  - There are some handy things you can do if you group interfaces together. For example, imagine a VM host system with 2 interfaces for management and 8 for data traffic. You could group them into “mgmt” and “data” groups and then control all interfaces of a type together.
- **qlen 1000**
  - The interface has a 1000 packet queue. The 1001st packet would be dropped.

### Data Link Layer - Layer 2

- **link/ether**
  - MAC (Medium Access Control) address of the interface

### Network Layer - Layer 3

- **inet**
  - The IPv4 interface configuration
    - **scope global** - This address is globally reachable. Other options include link and host.
    - **dynamic** - This IP address was assigned by DHCP. The lease length is listed in “valid_lft”.
    - **vmbr0** - A reference back to the interface this IP address is associated with.
- **inet6**
  - The IPv6 interface configuration
    - Only the link local address is configured. IPv4 link-local addresses are assigned from address block 
    `169.254.0.0/16`. In IPv6, they are assigned from the block `fe80::`


## Media layers

| OSI Layer | Name      | Protocol data unit (PDU)   | Function                                                                                         |
|-----------|-----------|----------------------------|--------------------------------------------------------------------------------------------------|
| 3         | Network   | Packet                     | Structuring and managing a multi-node network, including addressing, routing and traffic control |
| 2         | Data Link | Frame                      | Transmission of data frames between two nodes connected by a physical layer                      |
| 1         | Physical  | Bit, Symbol                | Transmission and reception of raw bit streams over a physical medium                             |