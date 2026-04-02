# 03 - Primeros recursos de Kubernetes con Terraform

## Objetivo

Aprender a crear recursos de Kubernetes con Terraform en lugar de aplicar manifiestos YAML manualmente con kubectl.

## Herramientas usadas

- Terraform
- Kubernetes
- kubectl
- kind

## Conceptos básicos

### Provider

Un provider es el componente que permite a Terraform comunicarse con una plataforma externa.  
En este caso, el provider de Kubernetes permite que Terraform cree recursos dentro del clúster.

### State

Terraform guarda un estado de los recursos que gestiona.  
Ese estado le permite comparar lo que existe con lo que se desea crear o modificar.

### Plan

El comando `terraform plan` muestra qué cambios va a realizar Terraform antes de aplicarlos.

### Apply

El comando `terraform apply` ejecuta los cambios definidos en los archivos `.tf`.

## Configuración

### Archivo: `terraform/providers.tf`

```hcl
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
  }
}

provider "kubernetes" {
  config_path    = "C:/Users/yojos/.kube/config"
  config_context = "kind-local-cloud-lab"
}
```

### Archivo: terraform/main.tf

```hcl
resource "kubernetes_namespace_v1" "lab_tf" {
  metadata {
    name = "lab-tf"
  }
}

resource "kubernetes_deployment_v1" "nginx_demo" {
  metadata {
    name      = "nginx-demo"
    namespace = kubernetes_namespace_v1.lab_tf.metadata[0].name
    labels = {
      app = "nginx-demo"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx-demo"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx-demo"
        }
      }

      spec {
        container {
          name  = "nginx"
          image = "nginx:stable"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "nginx_demo_service" {
  metadata {
    name      = "nginx-demo-service"
    namespace = kubernetes_namespace_v1.lab_tf.metadata[0].name
  }

  spec {
    selector = {
      app = "nginx-demo"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
```

## Comandos:

cd .\terraform
terraform init -upgrade
terraform plan
terraform apply
terraform state list
kubectl get namespaces
kubectl get all -n lab-tf
kubectl port-forward -n lab-tf service/nginx-demo-service 8081:80
