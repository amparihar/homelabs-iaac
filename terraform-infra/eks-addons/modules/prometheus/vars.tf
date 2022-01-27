
variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled"
}

# Helm
variable "helm_release_name" {
  type        = string
  default     = "prometheus"
  description = "Helm release name"
}

variable "helm_chart_name" {
  type        = string
  default     = "prometheus"
  description = "Helm chart name"
}

# K8s
variable "helm_repo_url" {
  type        = string
  default     = "https://prometheus-community.github.io/helm-charts"
  description = "Helm repository"
}
variable "namespace" {
  type        = string
  default     = "prometheus"
  description = "Helm chart namespace"
}
variable "create_namespace" {
  type        = bool
  default     = true
}