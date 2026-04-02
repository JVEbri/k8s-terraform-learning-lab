# 02 - Primer despliegue en Kubernetes

## Objetivo

Desplegar una aplicación simple en Kubernetes para entender los conceptos básicos del clúster antes de usar Terraform.

## Herramientas usadas

- Kubernetes
- kubectl
- nginx

## Conceptos básicos

### Namespace

Un namespace sirve para organizar recursos dentro del clúster Kubernetes.  
Nos permite separar nuestros recursos del laboratorio de otros recursos del sistema.

### Pod

Un pod es la unidad mínima que Kubernetes ejecuta.  
Normalmente dentro de un pod corre uno o varios contenedores.

### Deployment

Un deployment define el estado deseado de una aplicación.  
Por ejemplo, permite indicar que queremos que siempre exista 1 instancia de un pod ejecutándose.

### Service

Un service permite acceder de forma estable a los pods.  
Como los pods pueden recrearse y cambiar de IP, el service actúa como punto de acceso fijo dentro del clúster.

## Configuración

### Archivo: `k8s/manifests/namespace.yaml`

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: lab
```

### Archivo: k8s/manifests/nginx-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-demo
  namespace: lab
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-demo
  template:
    metadata:
      labels:
        app: nginx-demo
    spec:
      containers:
        - name: nginx
          image: nginx:stable
          ports:
            - containerPort: 80
```

### Archivo: k8s/manifests/nginx-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-demo-service
  namespace: lab
spec:
  selector:
    app: nginx-demo
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```

## Comandos:

kubectl apply -f .\k8s\manifests\namespace.yaml
kubectl apply -f .\k8s\manifests\nginx-deployment.yaml
kubectl apply -f .\k8s\manifests\nginx-service.yaml
kubectl get all -n lab
kubectl port-forward -n lab service/nginx-demo-service 8080:80
