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
variable "nat_gateways" {
  type    = number
  default = 1
  description = "Number of NAT Gateways to be provisioned. This number cannot exceed the total number of Public Subnets in all AZs"
}
