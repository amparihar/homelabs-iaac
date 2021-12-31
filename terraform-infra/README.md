# Introduction 
A terraform module to create a managed Kubernetes cluster on AWS EKS(Fargate)

# Getting Started
Download and install the latest terraform binary for your operating system from https://terrform.io

# Build and Test

1. Create EKS Cluster
Change into the eks directory and create the EKS cluster infrastructure.

cd eks
terraform init
terraform validate
terraform plan -out <FILENAME1> -var-file=<FILENAME>
terraform apply <FILENAME1>

2. Create eks addon resource
Change into the eks-addons directory and create the resources after EKS Cluster is created successfully as above.

cd eks-addons
terraform init
terraform validate
terraform plan -out <FILENAME2> -var=cluster_name=<CLUSTERNAME> -var=vpc_id=<VPCID> 
terraform apply <FILENAME2>

*******************************
####  UPDATE "service_account.yaml" with the value of the output variable named "appmesh_controller_sa_arn" 
*******************************

3. DELETING the Cluster
First, delete the K8s resources followed by the EKS Cluster

### DELETE add-ons
cd eks-addons
terraform destroy -var=cluster_name=<CLUSTERNAME> -var=vpc_id=<VPCID> 

### DELETE eks
cd eks
terraform destroy -var-file=<FILENAME>
