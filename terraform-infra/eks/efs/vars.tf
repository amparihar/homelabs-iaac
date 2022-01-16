variable "app_name" {
  type = string
}
variable "stage_name" {
  type = string
}

variable "vpcid" {
  type = string
}
variable "private_subnets" {
    type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}

variable "create_efs" {
    type = bool
    default = false
}
