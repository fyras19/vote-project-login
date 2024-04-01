resource "kubernetes_persistent_volume_claim_v1" "db-data" {
  metadata {
    name = "db-data"
  }
  spec {
    storage_class_name = "standard"
    resources {
      requests = {
        storage = "100Mi"
      }
    }
    access_modes = ["ReadWriteOnce"]
  }
}
