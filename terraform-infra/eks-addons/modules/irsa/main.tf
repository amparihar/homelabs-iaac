
locals {
  assume_role_policy = data.aws_iam_policy_document.k8s_sa_assume_role_iam_policy.json
  sa_role_enabled    = (var.appmesh_controller_enabled || var.kubernetes_external_secrets_enabled) ? 1 : 0
}

# Appmesh controller role & policies
resource "aws_iam_role" "sa" {
  count              = local.sa_role_enabled
  assume_role_policy = local.assume_role_policy
}

# add AWS managed IAM policies to appmesh controller sa
resource "aws_iam_role_policy_attachment" "AWSAppMeshFullAccess" {
  count      = var.appmesh_controller_enabled ? 1 : 0
  role       = aws_iam_role.sa[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshFullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSCloudMapFullAccess" {
  count      = var.appmesh_controller_enabled ? 1 : 0
  role       = aws_iam_role.sa[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudMapFullAccess"
}

resource "aws_iam_role_policy_attachment" "AWSCloudMapDiscoverInstanceAccess" {
  count      = var.appmesh_controller_enabled ? 1 : 0
  role       = aws_iam_role.sa[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudMapDiscoverInstanceAccess"
}

resource "aws_iam_role_policy_attachment" "AWSAppMeshEnvoyAccess" {
  count      = var.appmesh_controller_enabled ? 1 : 0
  role       = aws_iam_role.sa[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
}

resource "aws_iam_role_policy_attachment" "AWSXRayDaemonWriteAccess" {
  count      = var.appmesh_controller_enabled ? 1 : 0
  role       = aws_iam_role.sa[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}

resource "aws_iam_role_policy_attachment" "CloudWatchLogsFullAccess" {
  count      = var.appmesh_controller_enabled ? 1 : 0
  role       = aws_iam_role.sa[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# kubernetes external secrets role & policies
resource "aws_iam_policy" "kubernetes_external_secrets_sa" {
  count  = var.kubernetes_external_secrets_enabled ? 1 : 0
  path   = "/" # Path in which to create the policy
  policy = data.aws_iam_policy_document.kubernetes_external_secrets_sa_iam_policy.json
}

resource "aws_iam_role_policy_attachment" "kubernetes_external_secrets_sa" {
  count      = var.kubernetes_external_secrets_enabled ? 1 : 0
  role       = aws_iam_role.sa[count.index].name
  policy_arn = aws_iam_policy.kubernetes_external_secrets_sa[count.index].arn
}

output "assume_role_policy" {
  value = local.assume_role_policy
}

output "service_account_role_arn" {
  value = length(aws_iam_role.sa.*.arn) > 0 ? aws_iam_role.sa[0].arn : "Please use the fargate pod execution role arn"
}
