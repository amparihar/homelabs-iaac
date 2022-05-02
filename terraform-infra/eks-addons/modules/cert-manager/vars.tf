
variable "enabled" {
  type        = bool
  default     = false
  description = "Variable indicating whether deployment is enabled"
}

# Helm
variable "helm_release_name" {
  type        = string
  default     = "cert-manager"
  description = "Helm release name"
}

variable "helm_chart_name" {
  type        = string
  default     = "cert-manager"
  description = "Helm chart name"
}

variable "helm_chart_version" {
  type = string
  default = "1.6.2"
}

# K8s
variable "helm_repo_url" {
  type        = string
  default     = "https://charts.jetstack.io"
  description = "Helm repository"
}
variable "namespace" {
  type        = string
  default     = "cert-manager"
  description = "Helm chart namespace"
}
variable "create_namespace" {
  type        = bool
  default     = true
}