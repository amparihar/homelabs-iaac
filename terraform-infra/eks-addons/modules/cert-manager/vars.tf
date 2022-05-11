
variable "cm_enabled" {
  type        = bool
  default     = false
  description = "Variable indicating whether deployment is enabled"
}

# Helm
variable "cm_helm_release_name" {
  type        = string
  default     = "cert-manager"
  description = "Helm release name"
}

variable "cm_helm_chart_name" {
  type        = string
  default     = "cert-manager"
  description = "Helm chart name"
}

variable "cm_helm_chart_version" {
  type = string
  default = "1.6.2"
}

# K8s
variable "cm_helm_repo_url" {
  type        = string
  default     = "https://charts.jetstack.io"
  description = "Helm repository"
}
variable "cm_namespace" {
  type        = string
  default     = "cert-manager"
  description = "Helm chart namespace"
}
variable "cm_create_namespace" {
  type        = bool
  default     = true
}

# AWSPCA
variable "awspca_helm_release_name" {
  type        = string
  default     = "awspca"
  description = "Helm release name"
}

variable "awspca_helm_chart_name" {
  type        = string
  default     = "awspca"
  description = "Helm chart name"
}

variable "awspca_helm_chart_version" {
  type = string
  default = "1.2.1"
}

# K8s
variable "awspca_helm_repo_url" {
  type        = string
  default     = "https://cert-manager.github.io/aws-privateca-issuer"
  description = "Helm repository"
}
variable "awspca_namespace" {
  type        = string
  default     = "aws-private-ca-issuer"
  description = "Helm chart namespace"
}
variable "awspca_create_namespace" {
  type        = bool
  default     = false
}

variable "region_id" {
  type = string
}

variable "irsa_assume_role_policy" {
  type = string
}

