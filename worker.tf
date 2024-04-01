resource "kubernetes_deployment_v1" "worker-deployment" {
  depends_on = [module.db-service, module.redis-service]
  metadata {
    name = "worker-deployment"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        "app" = "worker"
      }
    }
    template {
      metadata {
        name = "worker"
        labels = {
          "app" = "worker"
        }
      }
      spec {
        container {
          image = docker_image.worker.name
          name  = "worker"
        }
      }
    }
  }
}
