resource "kubernetes_namespace" "appmesh_controller" {
  count = var.appmesh_controller_enabled ? 1 : 0
  metadata {
    annotations = {
      name = var.appmesh_controller_namespace
    }
    name = var.appmesh_controller_namespace
  }
}

resource "kubernetes_service_account" "appmesh_controller" {
  count = var.appmesh_controller_enabled ? 1 : 0
  metadata {
    name      = "appmesh-controller"
    namespace = var.appmesh_controller_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = var.service_account_role_arn
    }
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name"      = "appmesh-controller"
    }
  }
}

resource "kubernetes_secret" "appmesh_controller" {
count = var.appmesh_controller_enabled ? 1 : 0
  metadata {
    name      = "appmesh-controller-secret"
    namespace = var.appmesh_controller_namespace
    annotations = {
      "kubernetes.io/service-account.name" = "appmesh-controller"
    }
}

resource "helm_release" "app-mesh-controller" {
  count            = var.appmesh_controller_enabled ? 1 : 0
  name             = var.appmesh_controller_helm_release_name
  repository       = var.appmesh_controller_helm_repo_url
  chart            = var.appmesh_controller_helm_chart_name
  namespace        = var.appmesh_controller_namespace
  create_namespace = var.appmesh_controller_create_namespace
  version          = var.appmesh_controller_helm_version

  set {
    name  = "region"
    value = var.region_id
  }
  set {
    name  = "serviceAccount.create"
    value = "false"
  }
  set {
    name  = "serviceAccount.name"
    value = "appmesh-controller"
  }

  # inject the AWS X-Ray daemon sidecar in each pod scheduled to run on the mesh.
  set {
    name  = "tracing.enabled"
    value = tostring(var.xray_tracing_enabled)
  }

  # default provider
  set {
    name  = "tracing.provider"
    value = "x-ray"
  }

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.${var.region_id}.amazonaws.com/amazon/appmesh-controller"
  }

  set {
    name  = "sidecar.image.repository"
    value = "840364872350.dkr.ecr.${var.region_id}.amazonaws.com/aws-appmesh-envoy"
  }

  set {
    name  = "init.image.repository"
    value = "840364872350.dkr.ecr.${var.region_id}.amazonaws.com/aws-appmesh-proxy-route-manager"
  }

  depends_on = [
    kubernetes_service_account.appmesh_controller
  ]
}


# resource "kubernetes_service_account" "envoy_proxy" {
#   count = length(var.app_namespaces)
#   metadata {
#     name      = "envoy-proxy-pod"
#     namespace = var.app_namespaces[count.index]
#     annotations = {
#       "eks.amazonaws.com/role-arn" = aws_iam_role.appmesh_controller_sa.arn
#     }
#   }
#   depends_on = [
#     aws_iam_role.appmesh_controller_sa
#   ]
# }

