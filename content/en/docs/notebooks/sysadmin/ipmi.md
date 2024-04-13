---
title: "IPMI"
description: >
    Working with the IPMI-over-LAN via ipmitool
---

**Dell Poweredge R510** is LOUD! Make it quiter with IMPI

IPMI (Intelligent Platform Management Interface) is an open standard for monitoring, 
logging, recovery, inventory, and control of hardware that is implemented independent 
of the main CPU, BIOS, and OS.

[ipmitool](https://github.com/ipmitool/ipmitool)

1. IPMI-over-LAN must be enabled
2. `apt-get install lm-sensors ipmitool`

```bash
# This command will enable manual fan control
ipmitool raw 0x30 0x30 0x01 0x00

# This command will control all fans, where ## is 00 to 64, which is mapped to 0% to 100%
ipmitool raw 0x30 0x30 0x02 0xff 0x##
# 
```

If you really want the [IPMI specification](/assets/pdf/ipmi-spec-v2-rev1-1.pdf)

