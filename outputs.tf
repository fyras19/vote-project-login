output "gcloud_config" {
  value = {
    project_id = var.project_id
    region     = var.region
    zone       = var.zone
  }
  description = "GCloud Project ID, Region and Zone"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.mycluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.mycluster.endpoint
  description = "GKE Cluster Host"
}

output "result_service_url" {
  value       = "http://${module.result-service.loadbalancer_ip}:4000"
  description = "URL to the result service"
}

output "vote_service_url" {
  value       = "http://${module.vote-service.loadbalancer_ip}:5000"
  description = "URL to the vote service"
}
