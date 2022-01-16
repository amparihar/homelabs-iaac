data "aws_caller_identity" "current" {}

# aws efs container storage interface driver IAM policy
data "aws_iam_policy_document" "aws_efs_csi_driver_sa_iam_policy" {
  statement {
    actions   = [
        "elasticfilesystem:DescribeAccessPoints",
        "elasticfilesystem:DescribeFileSystems"
      ]
    resources = ["arn:aws:elasticfilesystem:${var.region_id}:${data.aws_caller_identity.current.account_id}:file-system/*"]
  }
  statement {
    actions   = ["elasticfilesystem:CreateAccessPoint"]
    resources = ["arn:aws:elasticfilesystem:${var.region_id}:${data.aws_caller_identity.current.account_id}:file-system/*"]
    
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }
  statement {
    actions   = ["elasticfilesystem:DeleteAccessPoint"]
    resources = ["*"]
    
    condition {
      test     = "StringLike"
      variable = "aws:ResourceTag/efs.csi.aws.com/cluster"
      values   = ["true"]
    }
  }
}