resource "google_container_cluster" "mycluster" {
  name     = "${var.project_id}-gke"
  location = var.zone

  node_pool {
    name               = "default-pool"
    initial_node_count = 3
    node_config {
      machine_type = "n1-standard-2"
    }
  }

  network    = google_compute_network.myvpc.name
  subnetwork = google_compute_subnetwork.mysubnet.name
}
