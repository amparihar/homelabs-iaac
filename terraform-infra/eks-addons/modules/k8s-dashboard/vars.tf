# kubernetes-dashboard
variable "k8s_dashboard_enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled"
}

variable "metrics_server_enabled" {
  type = bool
}

# Helm
variable "k8s_dashboard_helm_chart_name" {
  type        = string
  default     = "kubernetes-dashboard"
  description = "Helm chart name to be installed"
}
variable "k8s_dashboard_helm_release_name" {
  type        = string
  default     = "k8s-dashboard"
  description = "Helm release name"
}
variable "k8s_dashboard_helm_repo_url" {
  type        = string
  default     = "https://kubernetes.github.io/dashboard"
  description = "Helm repository"
}

# K8S
variable "k8s_dashboard_create_namespace" {
  type        = bool
  default     = true
  description = "Whether to create k8s namespace with name defined by `k8s_dashboard_namespace`"
}
variable "k8s_dashboard_namespace" {
  type        = string
  default     = "kubernetes-dashboard"
  description = "The k8s namespace in which the kubernetes-dashboard service account has been created"
}
