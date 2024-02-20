locals {
  name_suffix = "${var.app_name}-${var.stage_name}"
  subnet_ids  = concat((var.private_networking ? [] : var.public_subnet_ids), var.private_subnet_ids)
}
resource "aws_eks_cluster" "main" {
  name = var.cluster_name
  # control plane logging to enable
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    subnet_ids = local.subnet_ids
  }

  role_arn = var.role_arn
  version  = var.cluster_version

  tags = {
    Name = "eks-cluster-${local.name_suffix}"
  }
}

data "tls_certificate" "main" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer

  depends_on = [
    aws_eks_cluster.main
  ]
}

resource "aws_iam_openid_connect_provider" "cluster_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.main.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.main.identity[0].oidc[0].issuer

  depends_on = [
    data.tls_certificate.main
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.main.name
  addon_name                  = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"

  configuration_values = jsonencode({
    computeType = "Fargate"
    resources = {
      limits = {
        cpu = "0.25"
        memory = "256M"
      }
      requests = {
        cpu = "0.25"
        memory = "256M"
      }
    }
  })
}

# # codeDNS patch
# # https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html#fargate-gs-coredns

# data "aws_eks_cluster_auth" "main" {
#   name = aws_eks_cluster.main.name
# }

# data "template_file" "kubeconfig" {
#   template = <<EOF
# apiVersion: v1
# kind: Config
# current-context: terraform
# clusters:
# - name: main
#   cluster:
#     certificate-authority-data: ${aws_eks_cluster.main.certificate_authority.0.data}
#     server: ${aws_eks_cluster.main.endpoint}
# contexts:
# - name: terraform
#   context:
#     cluster: main
#     user: terraform
# users:
# - name: terraform
#   user:
#     token: ${data.aws_eks_cluster_auth.main.token}
# EOF

#   depends_on = [
#     aws_eks_cluster.main,
#     data.aws_eks_cluster_auth.main
#   ]
# }

# resource "null_resource" "coredns_patch" {
#   provisioner "local-exec" {
#     interpreter = ["/bin/bash", "-c"]
#     command     = <<EOF
# kubectl --kubeconfig=<(echo '${data.template_file.kubeconfig.rendered}') \
#   patch deployment coredns \
#   -n kube-system \
#   --type=json \
#   -p='[{"op": "remove", "path": "/spec/template/metadata/annotations", "value": "eks.amazonaws.com/compute-type"}]'
# EOF
#   }
#   #   provisioner "local-exec" {
#   #     when    = destroy
#   #     command = <<EOF
#   # kubectl --kubeconfig=<(echo '${self.triggers.kubeconfig}') \
#   #   annotate deployment.apps/coredns \
#   #   -n kube-system \
#   #   eks.amazonaws.com/compute-type="ec2" 
#   # EOF
#   #   }

#   depends_on = [
#     module.core_fargate_profile.id
#   ]
# }

output "eks_cluster_id" {
  value = aws_eks_cluster.main.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.main.name
}

output "eks_cluster_status" {
  value = aws_eks_cluster.main.status
}