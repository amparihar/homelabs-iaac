variable "app_name" {
  type    = string
  default = "EOMFTrading"
}
variable "stage_name" {
  type    = string
  default = "non-prod"
}
variable "aws_region" {
  type    = string
  default = "mumbai"
}
variable "aws_regions" {
  type = map(string)
  default = {
    north-virginia = "us-east-1"
    mumbai         = "ap-south-1"
  }
}
variable "cluster_name" {
  type        = string
  description = "The name of an existing EKS Cluster"
  validation {
    condition     = length(var.cluster_name) > 0
    error_message = "Cluster Name is required."
  }
}
variable "vpc_id" {
  type        = string
  description = "The Id of an existing VPC"
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC Id is required."
  }
}
variable "app_namespaces" {
  type    = list(string)
  default = []
}
