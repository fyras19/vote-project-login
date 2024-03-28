resource "kubernetes_service_v1" "service" {
  metadata {
    name = var.metadata_name
  }
  spec {
    type = var.service_type
    selector = {
      "app" = var.label_app
    }
    port {
      port        = var.service_ports.port
      target_port = var.service_ports.targetPort
    }
  }
}

output "loadbalancer_ip" {
  value = var.service_type == "LoadBalancer" ? kubernetes_service_v1.service.status[0].load_balancer[0].ingress[0].ip : null
}
