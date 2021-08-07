
resource "helm_release" "k8s_dashboard" {
  count = var.k8s_dashboard_enabled ? 1 : 0

  name       = var.k8s_dashboard_helm_release_name
  repository = var.k8s_dashboard_helm_repo_url
  chart      = var.k8s_dashboard_helm_chart_name
  # this chart version is fully compatible with k8s version 1.19
  version          = "3.0.1"
  namespace        = var.k8s_dashboard_namespace
  create_namespace = var.k8s_dashboard_create_namespace

  // sidecar container
  // get metrics from the Metrics server and push them to the dashboard
  set {
    name  = "metricsScraper.enabled"
    value = "true"
  }

  set {
    name  = "metrics-server.enabled"
    value = tostring(var.metrics_server_enabled)
  }

  set {
    name  = "rbac.clusterReadOnlyRole"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "kubernetes-dashboard-admin-user"
  }

}

resource "kubernetes_service_account" "kubernetes_dashboard_sa" {
  # count = var.k8s_dashboard_enabled ? 1 : 0
  count = 0
  metadata {
    name      = "kubernetes-dashboard-admin-user"
    namespace = var.k8s_dashboard_namespace

    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name"      = "kubernetes-dashboard"
    }
  }

  depends_on = [
    helm_release.k8s_dashboard
  ]
}

resource "kubernetes_cluster_role_binding" "kubernetes_dashboard_sa" {
  # count = var.k8s_dashboard_enabled ? 1 : 0
  count = 0
  metadata {
    name = "kubernetes-dashboard-admin-user-cluster-rolebinding"
    labels = {
      "app.kubernetes.io/name" = "kubernetes-dashboard"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "kubernetes-dashboard-admin-user"
    namespace = var.k8s_dashboard_namespace
  }

  depends_on = [
    kubernetes_service_account.kubernetes_dashboard_sa
  ]
}

output "helm_release_attributes" {
  description = "Helm release attribute for kubernetes dashboard"
  value       = helm_release.k8s_dashboard
}
