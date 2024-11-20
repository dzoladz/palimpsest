---
title: "iptables"
description: >
  Administration tool for IPv4 packet filtering and NAT
---

* Show Rules (list)
`iptables -L`

* Showing Packet Counts and Aggregate Size
`iptables -L -v`

* List Rules by Chain and Number
`iptables -L --line-numbers`

* Delete Rule by Number
`iptables -D 3`