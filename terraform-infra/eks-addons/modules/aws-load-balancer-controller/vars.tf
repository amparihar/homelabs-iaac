variable "app_name" {
  type = string
}
variable "stage_name" {
  type = string
}
variable "irsa_assume_role_policy" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "region_id" {
  type = string
}
variable "load_balancer_cluster_role_rules" {
  type = list(object({ api_groups = list(string), resources = list(string), verbs = list(string) }))
  default = [
    {
      api_groups = [""]
      resources  = ["endpoints"],
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = [""]
      resources  = ["events"]
      verbs      = ["create", "patch"]
    },
    {
      api_groups = [""]
      resources  = ["namespaces"]
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = [""]
      resources  = ["nodes"]
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = [""]
      resources  = ["pods"]
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = [""]
      resources  = ["pods/status"]
      verbs      = ["patch", "update"]
    },
    {
      api_groups = [""]
      resources  = ["secrets"]
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = [""]
      resources  = ["services"]
      verbs      = ["get", "list", "watch", "patch", "update"]
    },
    {
      api_groups = [""]
      resources  = ["services/status"]
      verbs      = ["patch", "update"]
    },
    {
      api_groups = ["elbv2.k8s.aws"]
      resources  = ["ingressclassparams"]
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = ["elbv2.k8s.aws"]
      resources  = ["targetgroupbindings"]
      verbs      = ["get", "list", "watch", "create", "delete", "patch", "update"]
    },
    {
      api_groups = ["elbv2.k8s.aws"]
      resources  = ["targetgroupbindings/status"]
      verbs      = ["patch", "update"]
    },
    {
      api_groups = ["extensions"]
      resources  = ["ingresses"]
      verbs      = ["get", "list", "patch", "update", "watch"]
    },
    {
      api_groups = ["extensions"]
      resources  = ["ingresses/status"]
      verbs      = ["patch", "update"]
    },
    {
      api_groups = ["networking.k8s.io"]
      resources  = ["ingressclasses"]
      verbs      = ["get", "list", "watch"]
    },
    {
      api_groups = ["networking.k8s.io"]
      resources  = ["ingresses"]
      verbs      = ["get", "list", "patch", "update", "watch"]
    },
    {
      api_groups = ["networking.k8s.io"]
      resources  = ["ingresses/status"]
      verbs      = ["patch", "update"]
    }
  ]
}
