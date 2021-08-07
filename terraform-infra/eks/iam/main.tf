# eks cluster role
resource "aws_iam_role" "eks_cluster_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_role_assume_role_iam_policy.json
}

resource "aws_iam_policy" "AmazonEKSClusterCloudWatchPolicy" {
  policy = data.aws_iam_policy_document.AmazonEKSClusterCloudWatchPolicy.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_iam_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_iam_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterCloudWatchPolicy" {
  policy_arn = aws_iam_policy.AmazonEKSClusterCloudWatchPolicy.arn
  role       = aws_iam_role.eks_cluster_iam_role.name
}

# eks fargate pod execution role
resource "aws_iam_role" "eks_fargate_pod_execution_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.eks_fargate_pod_execution_role_assume_role_iam_policy.json
}

resource "aws_iam_policy" "eks_fargate_pod_execution_iam_policy" {
  policy = data.aws_iam_policy_document.eks_fargate_pod_execution_iam_policy.json
}

# fluentbit
resource "aws_iam_policy" "eks_fargate_pod_execution_logging_iam_policy" {
  description = "Allow fargate profiles to write cloud watch logs"
  policy      = data.aws_iam_policy_document.eks_fargate_pod_execution_logging_iam_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_fargate_pod_execution_iam_policy" {
  policy_arn = aws_iam_policy.eks_fargate_pod_execution_iam_policy.arn
  role       = aws_iam_role.eks_fargate_pod_execution_iam_role.name
}

# fluentbit
resource "aws_iam_role_policy_attachment" "ks_fargate_pod_execution_logging_iam_policy" {
  policy_arn = aws_iam_policy.eks_fargate_pod_execution_logging_iam_policy.arn
  role       = aws_iam_role.eks_fargate_pod_execution_iam_role.name
}

output "eks_cluster_iam_role_name" {
  value = aws_iam_role.eks_cluster_iam_role.name
}

output "eks_cluster_iam_role_arn" {
  value = aws_iam_role.eks_cluster_iam_role.arn
}

output "eks_fargate_pod_execution_iam_role_name" {
  value = aws_iam_role.eks_fargate_pod_execution_iam_role.name
}

output "eks_fargate_pod_execution_iam_role_arn" {
  value = aws_iam_role.eks_fargate_pod_execution_iam_role.arn
}