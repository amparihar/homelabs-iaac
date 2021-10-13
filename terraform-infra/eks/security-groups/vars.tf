variable "app_name" {
  type = string
}
variable "stage_name" {
  type = string
}
variable "create_vpc" {
  type = bool
}
variable "vpcid" {
  type = string
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "private_networking" {
  type = bool
}
variable "ingress_gateway_container_port" {
  type = number
}
variable "multi_az_deployment" {
  type = bool
}