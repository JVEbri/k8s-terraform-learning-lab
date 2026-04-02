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
    replicas = 2

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