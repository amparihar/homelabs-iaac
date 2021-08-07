
output "assume_role_policy" {
  value = data.aws_iam_policy_document.k8s_sa_assume_role_iam_policy.json
}
