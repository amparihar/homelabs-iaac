variable "app_name" {
  type    = string
  default = "homelabs"
}
variable "stage_name" {
  type    = string
  default = "non-prod"
}
variable "aws_region" {
  type    = string
  default = "ohio"
}
variable "aws_regions" {
  type = map(string)
  default = {
    mumbai         = "ap-south-1"
    ohio           = "us-east-2"
  }
}
variable "cluster_name" {
  type        = string
  description = "The name of an existing EKS Cluster"
  validation {
    condition     = length(var.cluster_name) > 0
    error_message = "Cluster Name is required."
  }
}
variable "vpc_id" {
  type        = string
  description = "The Id of an existing VPC"
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC Id is required."
  }
}
variable "app_namespaces" {
  type    = list(string)
  default = []
}

variable "app_xray_tracing_enabled" {
  type        = bool
  description = "Variable indicating whether x-ray tracing is enabled"
}

variable "app_appmesh_controller_enabled" {
  type        = bool
  description = "Variable indicating whether appmesh deployment is enabled"
}

variable "app_kubernetes_external_secrets_enabled" {
  type        = bool
  description = "Variable indicating whether k8s external secrets deployment is enabled"
}

variable "app_app_mesh_service_discovery_enabled" {
  type        = bool
  description = "Variable indicating whether to use cloud map based service discovery with appmesh"
}
variable "app_aws_efs_csi_driver_enabled" {
  type        = bool
  description = "Variable indicating whether container storage interface(CSI) driver is enabled"
}
variable "app_prometheus_enabled" {
  type        = bool
}
variable "app_cwagent_prometheus_enabled" {
  type = bool
}
variable "app_opa_enabled" {
  type = bool
}