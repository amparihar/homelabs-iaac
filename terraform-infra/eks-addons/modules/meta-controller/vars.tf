variable "enabled" {
  type        = bool
  default     = false
  description = "Variable indicating whether deployment is enabled"
}

# Helm
variable "helm_release_name" {
  type        = string
  default     = "metacontroller"
  description = "Helm release name"
}

variable "helm_chart_name" {
  type        = string
  default     = "metacontroller"
  description = "Helm chart name"
}

# K8s
variable "helm_repo_url" {
  type        = string
  default     = "oci://ghcr.io/metacontroller/metacontroller-helm"
  description = "Helm repository"
}
