resource "kubernetes_job_v1" "seed-job" {
  depends_on = [module.vote-service]
  metadata {
    name = "seed-job"
  }
  spec {
    backoff_limit = 4
    template {
      metadata {
        name = "seed-job"
      }
      spec {
        container {
          name  = "seed-data"
          image = docker_image.seed.name
        }
        restart_policy = "Never"
      }
    }
  }
}
