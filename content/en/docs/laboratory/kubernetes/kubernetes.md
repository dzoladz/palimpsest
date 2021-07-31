---
title: "Kubernetes"
linkTitle: "Kubernetes"
weight: 2
description: >
  K3s Kubernetes Distribution for ARM Processors
---

This is the future location for all of my application hosting experiments at OhioNET that are unusable by the organization. The idea is to build an environment for continued independent learning in technological areas that are focused on developing custom library-adjacent research applications, but are well beyond the capacities of my day job.

## 3-Node Cluster Computing Hardware

## K3s
The lightweight, certified Kubernetes distribution [K3s](https://k3s.io/) was selected. The K3s distro is designed from ARM64 architectures like the Raspberry Pi 4.

## Docker Compose to Kubernetes

[Kompose](https://kompose.io/) is a command-line conversion tool. It takes a Docker Compose file and translates it into Kubernetes resources. There's also a [GUI version](https://github.com/JadCham/komposeui) maintained on GitHub.

Basic Conversion to Single File
```bash
kompose convert -f docker-compose.yml -o kubernetes-output.yml
```

Convert to Helm Chart
```bash
kompose convert -c
```


## Extended Learning

- [An Ultimate Kubernetes Hands-on Labs](https://collabnix.github.io/kubelabs/)