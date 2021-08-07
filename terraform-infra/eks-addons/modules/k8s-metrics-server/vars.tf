# metrics-server
variable "metrics_server_enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled"
}

# Helm
variable "helm_release_name" {
  type        = string
  default     = "metrics-server"
  description = "Helm release name"
}

# K8s
variable "k8s_namespace" {
  type        = string
  default     = "kube-system"
  description = "The K8s namespace in which the metrics-server service account has been created"
}