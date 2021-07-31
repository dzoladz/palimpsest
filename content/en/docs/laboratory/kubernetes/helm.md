---
title: "Helm"
linkTitle: "Helm"
weight: 3
description: >
  Kubernetes management platform
---

[Helm](https://helm.sh/) is a tool for managing Kubernetes applications. Helm Charts contain Kubernetes objects that define an application and expected state. Helm uses charts to make it easier to create, install, and manage Kubernetes applications.

## Commands

## Issues

1. If attempting to install an application via Helm results in `Error: Kubernetes cluster unreachable`, make sure the KUBECONFIG environment variable is set properly:

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

2. An application gets stuck in a `CrashLoopBackOff` status and the Kubernetes logs show `exec user process caused "exec format error"`

The lab Kubernetes cluster is using Raspberry Pi 4s, which are 64-bit ARM architecture. The above is a common error when the container application is built for an x86 architecture. To resolve this issue, use a container targeted for 64-bit ARM.