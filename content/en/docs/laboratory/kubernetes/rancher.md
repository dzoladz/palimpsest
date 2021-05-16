---
title: "Rancher"
linkTitle: "Rancher"
weight: 2
description: >
  Kubernetes management platform
---

As of Rancher v2.5, Rancher can be installed on any Kubernetes cluster.
- RKE
- K3s **on Raspberry Pi 4 cluster**
- RKE2
- Amazon EKS

### Installing Rancher via Helm3 

1. Add the Rancher Helm chart repo

```bash
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
```

### Create a Namespace for Rancher resources

Rancher documentation states that this namespace should always be called `cattle-system`

```bash
kubectl create namespace cattle-system
```

### Install cert-manager

Rancher supports multiple SSL/TLS termination methods. As the laboratory cluster is on the local network and only accepting connections from the LAN, the following set of instructions will configure Rancher to generate its own certificates. Using Let's Encyprt and forwarding traffic from an external layer 7 load balancer are better options for production. 

# Install the [CustomResourceDefinition](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions) separately

```bash
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.crds.yaml
```

### Create the namespace for cert-manager

```bash
kubectl create namespace cert-manager
```

#### Add the Jetstack Helm repository

```bash
helm repo add jetstack https://charts.jetstack.io
```

#### Update your local Helm chart repository cache

```bash
helm repo update
```

#### Install the cert-manager Helm chart

```bash
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.4
```

#### Verify Deployment

```bash
kubectl get pods --namespace cert-manager
```

### Install Rancher via Helm

Set the hostname to the DNS name you will point to your load balancer.

```bash
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --ingress.tls.source=rancher \
  --set hostname=rancher.derekzoladz.com
```

### Confirm deployment of Rancher server

```bash
kubectl -n cattle-system rollout status deploy/rancher
```

## Troubleshooting

Ensure the KUBECONFIG environment variable is set

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

If Helm can't reach the k3s cluster
```bash
kubectl config view --raw >~/.kube/config
```
