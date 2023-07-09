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
# not supported on Fargate due to nonprivilege security context
resource "helm_release" "aws_efs_csi_driver" {
  count             = var.enabled ? 1 : 0

  name              = var.helm_release_name
  repository        = var.helm_repo_url
  chart             = var.helm_chart_name
 
  # version           = "2.2.2"
  version           = "2.4.6"
  namespace         = var.namespace
  create_namespace  = var.create_namespace
  
  set {
    name = "image.repository"
    value = "602401143452.dkr.ecr.${var.region_id}.amazonaws.com/eks/aws-efs-csi-driver"
  }
  
  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = element(aws_iam_role.aws_efs_csi_driver_sa.*.arn, count.index)
  }

  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }
  
  set {
    name = "node.serviceAccount.create"
    # We're using the same service account for both the nodes and controllers,
    # and we're already creating the service account in the controller config
    # above.
    value = "false"
  }
}

output "efs_csi_controller_sa_role_arn" {
  value = aws_iam_role.aws_efs_csi_driver_sa.*.arn
}

