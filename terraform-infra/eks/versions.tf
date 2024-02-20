# terraform {
#   required_version = ">= 0.13.1"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 3.50.0"
#     }
#   }
# }

# terraform {
#   required_version = ">= 0.14"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = ">= 3.0, < 4.0"
#     }
#   }
# }

terraform {
  required_version = ">= 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.34"
    }
  }
}