resource "helm_release" "cert_manager" {
  count             = var.enabled ? 1 : 0
  name              = var.helm_release_name
  chart             = var.helm_chart_name
  repository        = var.helm_repo_url
  namespace         = var.namespace
  create_namespace  = var.create_namespace
  version           = var.helm_chart_version
  
  set {
    name  = "installCRDs"
    value = "true"
  }
  set {
    name  = "webhook.securePort"
    value = "10260"
  }
}