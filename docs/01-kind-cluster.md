# 01 - Crear un clúster local con kind

## Objetivo

Levantar un clúster Kubernetes local para usarlo como base del laboratorio.

## Herramientas usadas

- Docker
- kind
- kubectl

## Configuración

Archivo: `k8s/kind-config.yaml`

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: local-cloud-lab
nodes:
  - role: control-plane
  - role: worker
```

## Comandos:

choco install kubernetes-cli
choco install kind
kind version
kind create cluster --config .\k8s\kind-config.yaml
kubectl cluster-info
kubectl get nodes
kubectl get pods -A
