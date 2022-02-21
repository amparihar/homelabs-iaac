
variable "enabled" {
  type        = bool
  default     = false
  description = "Variable indicating whether deployment is enabled"
}

# Helm
variable "helm_release_name" {
  type        = string
  default     = "gatekeeper"
  description = "Helm release name"
}

variable "helm_chart_name" {
  type        = string
  default     = "gatekeeper"
  description = "Helm chart name"
}

# K8s
variable "helm_repo_url" {
  type        = string
  default     = "https://open-policy-agent.github.io/gatekeeper/charts"
  description = "Helm repository"
}
variable "namespace" {
  type        = string
  default     = "gatekeeper-system"
  description = "Helm chart namespace"
}
variable "create_namespace" {
  type        = bool
  default     = true
}