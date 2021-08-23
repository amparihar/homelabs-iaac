data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kubernetes_external_secrets_sa_iam_policy" {
  statement {
    actions   = ["ssm:GetParameter"]
    resources = ["arn:aws:ssm:${var.region_id}:${data.aws_caller_identity.current.account_id}:parameter/*"]
  }

  statement {
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    resources = ["arn:aws:secretsmanager:${var.region_id}:${data.aws_caller_identity.current.account_id}:secret:*"]
  }

  statement {
    actions = [
      "kms:GetPublicKey",
      "kms:Decrypt",
      "kms:ListKeyPolicies",
      "kms:UntagResource",
      "kms:ListRetirableGrants",
      "kms:GetKeyPolicy",
      "kms:Verify",
      "kms:ListResourceTags",
      "kms:ReEncryptFrom",
      "kms:ListGrants",
      "kms:GetParametersForImport",
      "kms:DescribeCustomKeyStores",
      "kms:ListKeys",
      "kms:TagResource",
      "kms:Encrypt",
      "kms:GetKeyRotationStatus",
      "kms:ListAliases",
      "kms:ReEncryptTo",
      "kms:DescribeKey"
    ]
    resources = ["arn:aws:kms:${var.region_id}:${data.aws_caller_identity.current.account_id}:key/*"]
  }
}