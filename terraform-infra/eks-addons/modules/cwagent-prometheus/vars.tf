variable "enabled" {
    type = bool
    default = false
}
variable "irsa_assume_role_policy" {
    type = string
}
variable "helm_release_name" {
    type = string
    default = "cwagent-prometheus"
}
variable "service_account_name" {
    type = string
    default = "cwagent-prometheus"
}
variable "namespace" {
    type = string
    default = "amazon-cloudwatch"
}
variable "cluster_name" {
    type = string
}
variable "region_name" {
    type = string
}
