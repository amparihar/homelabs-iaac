variable "app_name" {
  default = ""
}
variable "stage_name" {
  default = ""
}
variable "create_vpc" {}
variable "aws_availability_zones" {}
variable "cidr" {}

variable "private_subnets" {}
variable "public_subnets" {}
variable "cluster_name" {}
variable "multi_az_deployment" {
  type = bool
}
