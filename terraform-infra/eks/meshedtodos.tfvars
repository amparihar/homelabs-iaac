aws_region = "ohio"
aws_regions = {
  mumbai         = "ap-south-1"
  ohio           = "us-east-2"
}
vpc_cidr                            = "10.10.0.0/20"
private_subnets                     = ["10.10.0.0/24", "10.10.1.0/24"]
public_subnets                      = ["10.10.10.0/24", "10.10.11.0/24"]
private_networking                  = true
multi_az_deployment                 = true
cluster_name                        = "meshed-todos-kluster"
app_ingress_gateway_container_port  = 8080
