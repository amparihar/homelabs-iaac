variable "aws_region" {
  type = string
}
variable "aws_regions" {
  type = map(string)
}
variable "create_vpc" {
  type    = bool
  default = true
}
variable "vpc_cidr" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "app_name" {
  type    = string
  default = "homelabs"
}
variable "stage_name" {
  type    = string
  default = "non-prod"
}
variable "cluster_name" {
  type = string
  description = "Choose a name for the EKS Cluster."
  validation {
    condition     = length(var.cluster_name) > 0
    error_message = "Cluster Name is required."
  }
}
variable "k8s_version" {
  description = "k8s cluster version"
  default     = "1.19"
  type        = string
}
variable "private_networking" {
  type    = bool
}
# max 2 AZs
variable "multi_az_deployment" {
  type = bool
}
variable "app_ingress_gateway_container_port" {
  type    = number
  default = 8080
}