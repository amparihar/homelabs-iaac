variable "app_name" {
  type = string
}
variable "stage_name" {
  type = string
}
variable "service_account_role_arn" {
  type = string
}
variable "region_id" {
  type = string
}
variable "xray_tracing_enabled" {
  type = bool
}

variable "app_namespaces" {
  type = list(string)
}

variable "appmesh_controller_enabled" {
  type = bool
}

# Helm
variable "appmesh_controller_helm_chart_name" {
  type        = string
  default     = "appmesh-controller"
  description = "Helm chart name to be installed"
}
variable "appmesh_controller_helm_release_name" {
  type        = string
  default     = "appmesh-controller"
  description = "Helm release name"
}
variable "appmesh_controller_helm_repo_url" {
  type        = string
  default     = "https://aws.github.io/eks-charts"
  description = "Helm repository"
}
variable "appmesh_controller_helm_version" {
  type        = string
  default     = "1.3.0"
  description = "Heml version"
}

# K8S
variable "appmesh_controller_create_namespace" {
  type        = bool
  default     = false
  description = "Whether to create appmesh-system namespace"
}
variable "appmesh_controller_namespace" {
  type        = string
  default     = "appmesh-system"
  description = "The namespace in which the appmesh-controller service account has been created"
}