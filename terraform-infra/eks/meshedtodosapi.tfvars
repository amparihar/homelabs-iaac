aws_region = "ohio"
aws_regions = {
  mumbai         = "ap-south-1"
  ohio           = "us-east-2"
}
vpc_cidr                            = "10.100.0.0/20"
private_subnets                     = ["10.100.0.0/24", "10.100.1.0/24"]
public_subnets                      = ["10.100.2.0/24", "10.100.3.0/24"]
private_networking                  = true
multi_az_deployment                 = true
cluster_name                        = "meshed-todos-api-kluster"
app_ingress_gateway_container_port  = 8080
