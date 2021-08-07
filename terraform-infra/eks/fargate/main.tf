resource "aws_eks_fargate_profile" "main" {
  cluster_name         = var.cluster_name
  fargate_profile_name = var.profile_name
  # Identifiers of private Subnets
  subnet_ids             = var.subnet_ids
  pod_execution_role_arn = var.pod_execution_role_arn

  # dynamic "selector" block
  dynamic "selector" {
    iterator = it
    for_each = var.selectors
    content {
      namespace = it.value["namespace"]
      labels    = lookup(it.value, "labels", {})
    }
  }
}

output "id" {
  value = aws_eks_fargate_profile.main.id
}

output "status" {
  value = aws_eks_fargate_profile.main.status
}