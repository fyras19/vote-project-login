module "redis-deployment" {
  source = "./deployments"

  metadata_name      = "redis-deployment"
  number_of_replicas = 1
  label_app          = "redis"
  container_name     = "redis"
  container_image    = docker_image.redis.name
  container_port     = 6379
}

module "redis-service" {
  source = "./services"

  depends_on    = [module.redis-deployment]
  metadata_name = "redis"
  label_app     = "redis"
  service_type  = "ClusterIP"
  service_ports = {
    port       = 6379
    targetPort = 6379
  }
}
