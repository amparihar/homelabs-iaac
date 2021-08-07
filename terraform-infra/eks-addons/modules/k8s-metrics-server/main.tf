resource "helm_release" "k8s_metrics_server" {
  count            = var.metrics_server_enabled ? 1 : 0
  name             = var.helm_release_name
  chart            = "${path.module}/metrics-server-chart"
  namespace        = var.k8s_namespace
  create_namespace = false
}

output "enabled" {
  value = var.metrics_server_enabled
}

