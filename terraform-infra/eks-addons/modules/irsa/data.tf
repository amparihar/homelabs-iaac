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