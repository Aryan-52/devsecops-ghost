provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment_v1" "ghost" {
  metadata {
    name = "ghost-app"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "ghost"
      }
    }
    template {
      metadata {
        labels = {
          app = "ghost"
        }
      }
      spec {
        container {
          image = "ghost:5-alpine"
          name  = "ghost"
          port {
            container_port = 2368
          }
          env {
            name  = "url"
            value = "http://localhost:30007"
          }
        }
      }
    }
  }
}
