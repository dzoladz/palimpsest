---
title: "Helm"
linkTitle: "Helm"
weight: 3
description: >
  Kubernetes package manager
---

[Helm](https://helm.sh/) is a tool for managing Kubernetes applications.

For Helm, there are a few important concepts:
- A **Chart** is a collection of files that describe a related set of Kubernetes resources that define an instance of a Kubernetes application.
- A **Repo** is a chart registry. Repositories can be added to Helm.
- A **Config** contains configuration information merged into a packaged chart to create a releasable object.
- A **Release** is a running instance of a chart using a specific configuration.

## Commands
A short list of common Helm commands

#### Repos
Add, update, and search repos for installable charts

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo apache
```

A valid chart repository must have an index file. The index file contains information about each chart in the chart repository. The following command will generate an index file based on a given local directory that contains packaged charts.

```bash
helm repo index
```

#### Install and Remove Charts

```bash
helm install provide-a-name-here bitnami/apache
helm uninstall provide-a-name-here bitnami/apache
```

#### Create New Chart Template

```bash
Helm create name-of-chart-dir
```







## Issues

1. If attempting to install an application via Helm results in `Error: Kubernetes cluster unreachable`, make sure the KUBECONFIG environment variable is set properly:

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

2. An application gets stuck in a `CrashLoopBackOff` status and the Kubernetes logs show `exec user process caused "exec format error"`

The lab Kubernetes cluster is using Raspberry Pi 4s, which are 64-bit ARM architecture. The above is a common error when the container application is built for an x86 architecture. To resolve this issue, use a container targeted for 64-bit ARM.