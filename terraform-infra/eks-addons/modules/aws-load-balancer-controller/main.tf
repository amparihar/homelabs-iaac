resource "aws_iam_role" "aws_load_balancer_controller_sa" {
  assume_role_policy = var.irsa_assume_role_policy
}

# IAM Policy for load balancer controller service account that allows it to make aws api calls
# IAM Policy reference : https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
# main branch is referred to get the latest policy
resource "aws_iam_policy" "aws_load_balancer_controller_sa" {
  path   = "/" # Path in which to create the policy
  # policy = data.aws_iam_policy_document.aws_load_balancer_controller_sa_iam_policy.json
  
  # https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.3/docs/install/iam_policy.json
  policy = "${file("iam-policy.json")}"
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller_sa" {
  role       = aws_iam_role.aws_load_balancer_controller_sa.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller_sa.arn
}

# Create k8s Service Account for load balancer controller
# Associate IAM Role with the service account, by annotating it
resource "kubernetes_service_account" "load_balancer_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.aws_load_balancer_controller_sa.arn
    }
    labels = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
    }
  }
  secret {
    name = "${kubernetes_secret.load_balancer_controller.metadata.0.name}"
  }
}

resource "kubernetes_secret" "load_balancer_controller" {
  metadata {
    name      = "load-balancer-controller-secret"
    namespace = "kube-system"
    # annotations = {
    #   "kubernetes.io/service-account.name" = "aws-load-balancer-controller"
    # }
  }
}

# Create Cluster Role for Service Account
resource "kubernetes_cluster_role" "load_balancer_controller" {
  count = 0
  metadata {
    name = "aws-load-balancer-controller-cluster-role"
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
  }

  dynamic "rule" {
    iterator = each
    for_each = var.load_balancer_cluster_role_rules
    content {
      api_groups = each.value["api_groups"]
      resources  = each.value["resources"]
      verbs      = each.value["verbs"]
    }
  }
}

# Create Cluster role binding
resource "kubernetes_cluster_role_binding" "load_balancer_controller" {
  count = 0
  metadata {
    name = "aws-load-balancer-controller-cluster-rolebinding"
    labels = {
      "app.kubernetes.io/name" = "aws-load-balancer-controller"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "aws-load-balancer-controller-cluster-role"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
  }
}

# Install aws load balancer controller
resource "helm_release" "load_balancer_controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  namespace        = "kube-system"
  create_namespace = false
  skip_crds        = false
  # version          = "1.3.2"
  version          = "1.5.4"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  # region and vpcId required for EKS Fargate 
  set {
    name  = "region"
    value = var.region_id
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }
  
  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "image.repository"
    value = "602401143452.dkr.ecr.${var.region_id}.amazonaws.com/amazon/aws-load-balancer-controller"
  }

  depends_on = [
    kubernetes_cluster_role_binding.load_balancer_controller
  ]
}

## 7. Create Ingress Manifest(routing rules)
## This will be part of the app resources
