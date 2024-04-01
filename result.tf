module "result-deployment" {
  source = "./deployments"

  depends_on         = [module.db-service]
  metadata_name      = "result-deployment"
  label_app          = "result"
  number_of_replicas = 1
  container_name     = "result"
  container_image    = docker_image.result.name
  container_port     = 4000
}

module "result-service" {
  source = "./services"

  depends_on    = [module.result-deployment]
  metadata_name = "result-loadbalancer"
  label_app     = "result"
  service_type  = "LoadBalancer"
  service_ports = {
    port       = 4000
    targetPort = 4000
  }
}
