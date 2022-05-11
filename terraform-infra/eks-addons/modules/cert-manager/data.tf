data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "aws_pca_sa_iam_policy" {
  statement {
    actions = [
      "acm-pca:DescribeCertificateAuthority",
      "acm-pca:GetCertificate",
      "acm-pca:IssueCertificate"
    ]
    resources = ["arn:aws:acm-pca:${var.region_id}:${data.aws_caller_identity.current.account_id}:certificate-authority/*"]
  }
}