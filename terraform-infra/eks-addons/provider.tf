terraform {
  required_version = "~> 1.0.9"
}

data "aws_eks_cluster" "main" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "main" {
  name = var.cluster_name
}

provider "aws" {
  region = var.aws_regions[var.aws_region]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.main.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.main.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.main.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.main.token
  }
}

module "irsa" {
  source                              = "./modules/irsa"
  oidc_url                            = data.aws_eks_cluster.main.identity[0].oidc[0].issuer
  region_id                           = var.aws_regions[var.aws_region]
  appmesh_controller_enabled          = var.app_appmesh_controller_enabled
  kubernetes_external_secrets_enabled = var.app_kubernetes_external_secrets_enabled
}

output "service_account_role_arn" {
  value = module.irsa.service_account_role_arn
}

module "aws_load_balancer_controller" {
  source                  = "./modules/aws-load-balancer-controller"
  app_name                = var.app_name
  stage_name              = var.stage_name
  cluster_name            = data.aws_eks_cluster.main.name
  vpc_id                  = var.vpc_id
  region_id               = var.aws_regions[var.aws_region]
  irsa_assume_role_policy = module.irsa.assume_role_policy
}

module "k8s_metrics_server" {
  source = "./modules/k8s-metrics-server"
}

module "kubernetes_dashboard" {
  source                 = "./modules/k8s-dashboard"
  metrics_server_enabled = !module.k8s_metrics_server.enabled
}

module "fargate_logging" {
  source       = "./modules/logging"
  cluster_name = data.aws_eks_cluster.main.name
  region_id    = var.aws_regions[var.aws_region]
}

module "app_mesh_controller" {
  source                     = "./modules/app-mesh-controller"
  app_name                   = var.app_name
  stage_name                 = var.stage_name
  region_id                  = var.aws_regions[var.aws_region]
  service_account_role_arn   = module.irsa.service_account_role_arn
  appmesh_controller_enabled = var.app_appmesh_controller_enabled
  xray_tracing_enabled       = var.app_xray_tracing_enabled
  app_namespaces             = var.app_namespaces
}

module "kubernetes_external_secrets" {
  source                              = "./modules/k8s-external-secrets"
  app_name                            = var.app_name
  stage_name                          = var.stage_name
  region_id                           = var.aws_regions[var.aws_region]
  kubernetes_external_secrets_enabled = var.app_kubernetes_external_secrets_enabled
  service_account_role_arn            = module.irsa.service_account_role_arn
}