resource "helm_release" "metacontroller" {
  count             = var.enabled ? 1 : 0
  name              = var.helm_release_name
  chart             = var.helm_chart_name
  repository        = var.helm_repo_url
  
  set {
    name  = "serviceAccount.name"
    value = "meta-controller"
  }
}