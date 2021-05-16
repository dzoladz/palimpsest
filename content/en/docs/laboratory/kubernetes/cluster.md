---
title: "Raspberry Pi Cluster"
linkTitle: "Raspberry Pi Cluster"
weight: 2
description: >
  Raspberry Pi 4, Model B Cluster - Distributed Computing
---

**Ligotti** - this 3 node pi cluster - is named after the philosophical horror writer [Thomas Ligotti](https://en.wikipedia.org/wiki/Thomas_Ligotti)

```bash
ligotti             192.168.1.10  | Controller, Master 
ligotti-worker-one  192.168.1.11  | Worker One
ligotti-worker-two  192.168.1.12  | Worker Two
```

## Hardware

| Quantity | Device |
|----------|--------|
| 3        | Raspberry Pi 4, Model B, 4 GB RAM |
| 3        | 64 GB, Samsung Evo, microSDXC UHS-I Card, Class 10, 1 FHD |
| 1        | TP-Link, TL-SG105, 5-Port Gigabit Switch |
| 3        | Micro Connectors Acrylic Stackable Raspberry Pi Case with Fan, Power |
| 4        | 1' CAT6 Ethernet Cables |

## OS

- Ubuntu Server 20.04.2 LTS 64-bit - [https://ubuntu.com/download/raspberry-pi](https://ubuntu.com/download/raspberry-pi)
- Flash OS images to SD cards - [Etcher](https://github.com/balena-io/etcher)

## Kubernetes

- [Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)
- [K3s](https://github.com/k3s-io/k3s)

## Install

#### Connect and Update
- Connect `ssh ubuntu@raspberry-pi-address`
- Update `sudo apt update && sudo apt upgrade`

#### Set Hostname
- Set hostname `hostnamectl set-hostname "ligotti"`

#### Enable c-groups
- Enabled c-groups `sudo sed -i '1s/^/cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory /' /boot/firmware/cmdline.txt`

#### Add User
- Add a user `adduser derekz`
- Enable passwordless sudo, `visudo` and add `derekz ALL=(ALL) NOPASSWD:ALL`

#### Static IP via Netplan
Edit `/etc/netplan/50-cloud-init.yaml`
```bash
network:
    ethernets:
        enp0s3:
            dhcp4: false
            addresses: [192.168.1.10/24]
            gateway4: 192.168.1.1
            nameservers:
              addresses: [192.168.1.51,8.8.8.8]
```
Apply changes `sudo netplan apply`

#### Reconnect
- Confirm IP `ip a`
- `reboot`

#### Login as newly-created user and create Master node
- `ssh derekz@192.168.1.10`
- `curl -sfL https://get.k3s.io | sh -`
- `sudo k3s kubectl get node`

#### Grab the K3s token
- `sudo cat /var/lib/rancher/k3s/server/node-token`

#### Set up worker nodes
- `curl -sfL https://get.k3s.io | K3S_URL=https://master_node_IP:6443 K3S_TOKEN=token_from_K3s sh -`
- Check K3s agent status `service k3s-agent status`
- Restart service, if needed `sudo service k3s-agent restart`
