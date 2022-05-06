# Introduction 
A terraform module to create a managed Kubernetes cluster on AWS EKS(Fargate)

# Getting Started
Download and install the latest terraform binary for your operating system from https://terrform.io

*******************************
Versions
K8s: 1.20
Helm chart version for aws load balancer controller : 1.3.2
Helm chart version for app mesh controller : 1.4.4
Helm chart for kubernetes dashboard : 3.0.1 (needs upgrade)
Helm chart for kubernetes external secrets : 8.5.0
*******************************

# Build and Test

1. Create EKS Cluster
Change into the eks directory and create the EKS cluster infrastructure.

cd eks
terraform init
terraform validate
terraform plan -out <FILENAME1> -var-file=<FILENAME>
terraform apply <FILENAME1>

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
aws eks update-kubeconfig --name eks-meshed-todos-api
kubectl patch deployment coredns -n kube-system --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
kubectl config set-context --current --namespace=todos-api
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

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

3. Deployment
cd ../../deployments/kustomize/meshed-todos-api/overlays/
kubectl apply -k stateless/

4. kubectl delete -k stateless/

5. DELETING the Cluster
First, delete the K8s resources followed by the EKS Cluster

### DELETE add-ons
cd eks-addons
terraform destroy -var=cluster_name=<CLUSTERNAME> -var=vpc_id=<VPCID> -auto-approve

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
kubectl annotate deployment.apps/coredns -n kube-system eks.amazonaws.com/compute-type="ec2"
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### DELETE eks
cd eks
terraform destroy -var-file=<FILENAME> -auto-approve
