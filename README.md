# Local Cloud Lab

Proyecto de aprendizaje para montar en local una pequeña plataforma con:

- Terraform
- Kubernetes local con kind
- API Gateway
- MinIO como almacenamiento S3-compatible
- Un microservicio backend
- Un frontend que consume el backend

## Objetivo

Aprender paso a paso infraestructura como código, despliegue local y comunicación entre servicios, documentando todo el proceso de forma didáctica.

## Estado actual

- [x] Crear clúster local con kind
- [x] Entender conceptos básicos de Kubernetes
- [x] Desplegar una aplicación simple en Kubernetes
- [x] Conectar Terraform con Kubernetes
- [ ] Desplegar un backend simple
- [ ] Desplegar un frontend simple
- [ ] Añadir API Gateway
- [ ] Añadir MinIO
- [ ] Integrar subida de archivos
- [ ] Documentar arquitectura

## Guía paso a paso

- [01 - Crear clúster local con kind](docs/01-kind-cluster.md)
- [02 - Primer despliegue en Kubernetes](docs/02-first-k8s-deployment.md)
- [03 - Primeros recursos de Kubernetes con Terraform](docs/03-terraform-kubernetes.md)

## Estructura del proyecto

- `k8s/`: configuración y manifiestos de Kubernetes
- `terraform/`: infraestructura como código con Terraform
- `backend/`: microservicio backend
- `frontend/`: frontend del laboratorio
- `docs/`: documentación paso a paso y notas de aprendizaje
