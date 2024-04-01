module "db-deployment" {
  source = "./deployments"

  metadata_name      = "db-deployment"
  label_app          = "db"
  number_of_replicas = 1
  container_image    = docker_image.db.name
  container_name     = "db"
  container_port     = 5432
  env_variables = [{
    name  = "POSTGRES_DB"
    value = "postgres"
    }, {
    name  = "POSTGRES_PASSWORD"
    value = "postgres"
    }, {
    name  = "POSTGRES_USER"
    value = "postgres"
  }]
  volume_mounts = [{
    mountPath = "/var/lib/postgresql/data"
    subPath   = "data"
    name      = "db-data"
  }]
  volumes = [{
    name = "db-data"
    persistentVolumeClaim = {
      claimName = kubernetes_persistent_volume_claim_v1.db-data.metadata[0].name
    }
  }]
}

module "db-service" {
  source = "./services"

  depends_on    = [module.db-deployment]
  metadata_name = "db"
  label_app     = "db"
  service_type  = "ClusterIP"
  service_ports = {
    port       = 5432
    targetPort = 5432
  }
}
