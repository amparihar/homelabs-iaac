variable "app_name" {
  type = string
}
variable "stage_name" {
  type = string
}
variable "region_id" {
  type = string
}
variable "service_account_role_arn" {
  type = string
}

variable "kubernetes_external_secrets_enabled" {
  type = bool
}

# Helm
variable "kubernetes_external_secrets_helm_chart_name" {
  type        = string
  default     = "kubernetes-external-secrets"
  description = "Helm chart name to be installed"
}
variable "kubernetes_external_secrets_helm_release_name" {
  type        = string
  default     = "kes"
  description = "Helm release name"
}
variable "kubernetes_external_secrets_helm_repo_url" {
  type        = string
  default     = "https://external-secrets.github.io/kubernetes-external-secrets/"
  description = "Helm repository"
}
variable "kubernetes_external_secrets_helm_version" {
  type        = string
  default     = "8.3.0"
  description = "Heml version"
}

# K8S
variable "kubernetes_external_secrets_create_namespace" {
  type        = bool
  default     = false
  description = "Whether to create default namespace"
}
variable "kubernetes_external_secrets_namespace" {
  type        = string
  default     = "external-secrets"
  description = "The namespace in which the kubernetes external secrets service account has been created"
}
