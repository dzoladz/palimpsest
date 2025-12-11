---
title: "macOS /home"
description: >
    Force access to macOS's home directory
---

1. Open the file `/etc/auto_master` and comment out the line `/home auto_home -nobrowse,hidefromfinder`
2. Execute `sudo automount -vc`, or reboot the system

You should be able to create directories within `/home`, e.g., `/home/oplin`
