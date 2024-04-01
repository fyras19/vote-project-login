module "vote-deployment" {
  source = "./deployments"

  depends_on         = [module.redis-service]
  metadata_name      = "vote-deployment"
  number_of_replicas = 3
  label_app          = "vote"
  container_name     = "vote"
  container_image    = docker_image.vote.name
  container_port     = 5000
}

module "vote-service" {
  source = "./services"

  depends_on    = [module.vote-deployment]
  metadata_name = "vote-loadbalancer"
  label_app     = "vote"
  service_type  = "LoadBalancer"
  service_ports = {
    port       = 5000
    targetPort = 5000
  }
}
