# EKS Cluster
data "aws_iam_policy_document" "eks_cluster_role_assume_role_iam_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "AmazonEKSClusterCloudWatchPolicy" {
  statement {
    actions = [
      "cloudwatch: *"
    ]
    resources = ["*"]
  }
}

# Fargate pod execution role
data "aws_iam_policy_document" "eks_fargate_pod_execution_role_assume_role_iam_policy" {

  #source_json = data.aws_iam_policy_document.k8s_sa_assume_role_iam_policy.json

  statement {
    #sid     = "pe_assume_role"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "eks_fargate_pod_execution_iam_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }
}

# fluentbit log policy
data "aws_iam_policy_document" "eks_fargate_pod_execution_logging_iam_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}
