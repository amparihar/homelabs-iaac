variable "irsa_assume_role_policy" {
    type = string
}
variable "region_id" {
    type = string
}
variable "helm_release_name" {
    type = string
    default = "aws-efs-csi-driver"
}
variable "helm_repo_url" {
    type = string
    default = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
}
variable "helm_chart_name" {
    type = string
    default = "aws-efs-csi-driver"
}
variable "namespace" {
    type = string
    default = "kube-system"
}
variable "create_namespace" {
    type = bool
    default = false
}
variable "enabled" {
    type = bool
    default = false
}
