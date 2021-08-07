variable "app_name" {
  type    = string
  default = ""
}
variable "stage_name" {
  type    = string
  default = ""
}
variable "cluster_name" {
  type = string
}
variable "cluster_version" {
  type = string
}
variable "role_arn" {
  type = string
}
variable "public_subnet_ids" {
  type    = list(string)
  default = []
}
variable "private_subnet_ids" {
  type    = list(string)
  default = []
}
variable "enabled_cluster_log_types" {
  type    = list(string)
  default = ["api", "audit", "authenticator", "scheduler", "controllerManager"]
}
variable "private_networking" {
  type = bool
}


