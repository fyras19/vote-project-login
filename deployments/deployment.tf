resource "kubernetes_deployment_v1" "deployment" {
  metadata {
    name = var.metadata_name
  }
  spec {
    selector {
      match_labels = {
        app = var.label_app
      }
    }
    replicas = var.number_of_replicas
    template {
      metadata {
        name = var.container_name
        labels = {
          app = var.label_app
        }
      }
      spec {
        container {
          image = var.container_image
          name  = var.container_name
          port {
            container_port = var.container_port
          }
          dynamic "env" {
            for_each = var.env_variables
            content {
              name  = env.value.name
              value = env.value.value
            }
          }
          dynamic "volume_mount" {
            for_each = var.volume_mounts
            content {
              mount_path = volume_mount.value.mountPath
              sub_path   = volume_mount.value.subPath
              name       = volume_mount.value.name
            }
          }
        }
        dynamic "volume" {
          for_each = var.volumes
          content {
            name = volume.value.name
            persistent_volume_claim {
              claim_name = volume.value.persistentVolumeClaim.claimName
            }
          }
        }
      }
    }
  }
}
