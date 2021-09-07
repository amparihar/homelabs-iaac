data "aws_caller_identity" "current" {}

# k8s sa role
# Policy that grants an k8s sa permission to assume the role
data "aws_iam_policy_document" "k8s_sa_assume_role_iam_policy" {
  statement {
    #sid     = "sa_assume_role"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    # condition {
    #   test     = "StringLike"
    #   variable = "${replace(var.oidc_url, "https://", "")}:sub"
    #   values   = ["system:serviceaccount:*"]
    # }

    condition {
      test     = "StringLike"
      variable = "${replace(var.oidc_url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(var.oidc_url, "https://", "")}",
        "cognito-identity.amazonaws.com"
      ]
    }
  }
}

# kubernetes external secrets policies
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
