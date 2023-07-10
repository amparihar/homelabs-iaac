# terraform {
#   required_version = ">= 0.13.1"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 3.50.0"
#     }
#   }
# }

terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0, < 4.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      # version = "2.7.1"
      version = "2.21.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.10.1"
    }
  }
}