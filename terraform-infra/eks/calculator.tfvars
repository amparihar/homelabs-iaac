aws_region = "mumbai"
aws_regions = {
  north-virginia = "us-east-1"
  mumbai         = "ap-south-1"
}
vpc_cidr            = "10.10.0.0/20"
private_subnets     = ["10.10.0.0/24", "10.10.1.0/24"]
public_subnets      = ["10.10.10.0/24", "10.10.11.0/24"]
private_networking  = true
multi_az_deployment = true
cluster_name        = "simple-calc-kluster"