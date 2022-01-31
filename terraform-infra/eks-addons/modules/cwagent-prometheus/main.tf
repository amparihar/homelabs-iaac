resource "aws_iam_role" "cwagent_prometheus_sa" {
  count                 = (var.enabled) ? 1 : 0
  assume_role_policy    = var.irsa_assume_role_policy
}

resource "aws_iam_role_policy_attachment" "cwagent_prometheus_sa" {
  count         = (var.enabled) ? 1 : 0
  role          = element(aws_iam_role.cwagent_prometheus_sa.*.name, count.index)
  policy_arn    = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "kubernetes_namespace" "cwagent_prometheus" {
  count = enabled ? 1 : 0
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }
}

resource "kubernetes_service_account" "cwagent_prometheus" {
  count = (var.enabled) ? 1 : 0
  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = element(aws_iam_role.cwagent_prometheus_sa.*.arn, count.index)
    }
    labels = {
      "app.kubernetes.io/component" = "cloudwatchagent"
      "app.kubernetes.io/name"      = "cwagent_prometheus"
    }
  }
}

resource "helm_release" "cwagent_prometheus" {
  count             = (var.enabled) ? 1 : 0
  name              = var.helm_release_name
  chart             = "${path.module}/helm-chart"
  namespace         = var.namespace
  create_namespace  = false
  
  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "regionName"
    value = var.region_name
  }

  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }
}