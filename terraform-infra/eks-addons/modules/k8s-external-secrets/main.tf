resource "aws_iam_role" "kubernetes_external_secrets_sa" {
  name               = "KubernetesExternalSecretsRole"
  assume_role_policy = var.irsa_assume_role_policy
}
resource "aws_iam_policy" "kubernetes_external_secrets_sa" {
  path   = "/" # Path in which to create the policy
  policy = data.aws_iam_policy_document.kubernetes_external_secrets_sa_iam_policy.json
}

resource "aws_iam_role_policy_attachment" "kubernetes_external_secrets_sa" {
  role       = aws_iam_role.kubernetes_external_secrets_sa.name
  policy_arn = aws_iam_policy.kubernetes_external_secrets_sa.arn
}

# Create k8s Service Account 
# Associate IAM Role with the service account, by annotating it
resource "kubernetes_service_account" "kubernetes_external_secrets" {
  count = var.kubernetes_external_secrets_create_sa ? 1 : 0
  metadata {
    name      = "kubernetes-external-secrets"
    namespace = var.kubernetes_external_secrets_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.kubernetes_external_secrets_sa.arn
    }
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name"      = "kubernetes-external-secrets"
    }
  }
}

resource "helm_release" "kubernetes_external_secrets" {
  count            = var.kubernetes_external_secrets_enabled ? 1 : 0
  name             = var.kubernetes_external_secrets_helm_release_name
  repository       = var.kubernetes_external_secrets_helm_repo_url
  chart            = var.kubernetes_external_secrets_helm_chart_name
  namespace        = var.kubernetes_external_secrets_namespace
  create_namespace = var.kubernetes_external_secrets_create_namespace
  version          = var.kubernetes_external_secrets_helm_version

  set {
    name  = "AWS_REGION"
    value = var.region_id
  }
  set {
    name  = "serviceAccount.create"
    value = tostring(!var.kubernetes_external_secrets_create_sa)
  }
  set {
    name  = "serviceAccount.name"
    value = "kubernetes-external-secrets"
  }
  set {
    name  = "serviceAccount.annotations\\.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.kubernetes_external_secrets_sa.arn
  }
  set {
    name  = "POLLER_INTERVAL_MILLISECONDS"
    value = "30000"
  }

  depends_on = [
    kubernetes_service_account.kubernetes_external_secrets
  ]
}

output "sa_role_arn" {
  value = aws_iam_role.kubernetes_external_secrets_sa.arn
}