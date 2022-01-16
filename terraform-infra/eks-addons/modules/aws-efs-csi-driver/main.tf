# aws efs container storage interface driver IAM policy
resource "aws_iam_role" "aws_efs_csi_driver_sa" {
  count  = var.enabled ? 1 : 0
  assume_role_policy = var.irsa_assume_role_policy
}

resource "aws_iam_policy" "aws_efs_csi_driver_sa" {
  count  = var.enabled ? 1 : 0
  path   = "/" # Path in which to create the policy
  policy = data.aws_iam_policy_document.aws_efs_csi_driver_sa_iam_policy.json
}

resource "aws_iam_role_policy_attachment" "aws_efs_csi_driver_sa" {
  count      = var.enabled ? 1 : 0
  role       = aws_iam_role.aws_efs_csi_driver_sa[count.index].name
  policy_arn = aws_iam_policy.aws_efs_csi_driver_sa[count.index].arn
}

# container storage interface
resource "helm_release" "aws_efs_csi_driver" {
  count             = var.enabled ? 1 : 0

  name              = var.helm_release_name
  repository        = var.helm_repo_url
  chart             = var.helm_chart_name
 
  version           = "2.2.1"
  namespace         = var.namespace
  create_namespace  = var.create_namespace
  
  set {
     name  = "serviceAccount.annotations\\.eks\\.amazonaws\\.com/role-arn"
     value = element(aws_iam_role.aws_efs_csi_driver_sa.*.arn, count.index)
  }
  
}

