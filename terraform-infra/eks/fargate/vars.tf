variable "app_name" {
  type = string
}
variable "stage_name" {
  type = string
}
variable "profile_name" {}
variable "cluster_name" {}
variable "subnet_ids" {
  type    = list(string)
  default = []
}
variable "pod_execution_role_arn" {
  type = string
  validation {
    condition     = length(var.pod_execution_role_arn) > 0
    error_message = "Fargate pod execution role arn is required."
  }
}
variable "selectors" {
  # type = list(object({ namespace : string, labels : map(string) }))
  type = any
}