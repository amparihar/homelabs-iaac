resource "helm_release" "cert_manager" {
  count             = var.cm_enabled ? 1 : 0
  name              = var.cm_helm_release_name
  chart             = var.cm_helm_chart_name
  repository        = var.cm_helm_repo_url
  namespace         = var.cm_namespace
  create_namespace  = var.cm_create_namespace
  version           = var.cm_helm_chart_version
  
  set {
    name  = "installCRDs"
    value = "true"
  }
  set {
    name  = "webhook.securePort"
    value = "10260"
  }
}

# # AWS PrivateCA Issuer AddOn
# resource "kubernetes_namespace" "aws_privateca_issuer" {
#   count = var.cm_enabled ? 1 : 0
#   metadata {
#     annotations = {
#       name = var.awspca_namespace
#     }
#     name = var.awspca_namespace
#   }
# }

# resource "aws_iam_role" "aws_pca_issuer" {
#   count = var.cm_enabled ? 1 : 0
#   assume_role_policy = var.irsa_assume_role_policy
# }

# resource "aws_iam_policy" "aws_pca_issuer" {
#   count = var.cm_enabled ? 1 : 0
#   path   = "/" # Path in which to create the policy
#   policy = data.aws_iam_policy_document.aws_pca_sa_iam_policy.json
# }

# resource "aws_iam_role_policy_attachment" "aws_pca_issuer" {
#   count = var.cm_enabled ? 1 : 0
#   role       = element(aws_iam_role.aws_pca_issuer.*.name, count.index)
#   policy_arn = element(aws_iam_policy.aws_pca_issuer.*.arn, count.index)
# }

# resource "kubernetes_service_account" "aws_pca_issuer" {
#   count = var.cm_enabled ? 1 : 0
#   metadata {
#     name      = "aws-pca-issuer"
#     namespace = var.awspca_namespace
#     annotations = {
#       "eks.amazonaws.com/role-arn" = element(aws_iam_role.aws_pca_issuer.*.arn, count.index)
#     }
#     labels = {
#       "app.kubernetes.io/component" = "aws-pca"
#       "app.kubernetes.io/name"      = "aws-pca-issuer"
#     }
#   }
# }

# resource "helm_release" "aws_privateca_issuer" {
#   count             = var.cm_enabled ? 1 : 0
#   name              = var.awspca_helm_release_name
#   chart             = var.awspca_helm_chart_name
#   repository        = var.awspca_helm_repo_url
#   namespace         = var.awspca_namespace
#   create_namespace  = var.awspca_create_namespace
#   # version           = var.awspca_helm_chart_version
  
#   set {
#     name  = "serviceAccount.create"
#     value = "false"
#   }
#   set {
#     name  = "serviceAccount.name"
#     value = "aws-pca-issuer"
#   }
# }