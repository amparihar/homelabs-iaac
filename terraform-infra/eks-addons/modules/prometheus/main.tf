resource "helm_release" "prometheus_server" {
  count             = var.enabled ? 1 : 0
  name              = var.helm_release_name
  chart             = var.helm_chart_name
  repository        = var.helm_repo_url
  namespace         = var.namespace
  create_namespace  = var.create_namespace
  
  set {
    name  = "alertmanager.persistentVolume.enabled"
    value = "false"
  }
  set {
    name  = "server.persistentVolume.enabled"
    value = "false"
  }
}

