# Introduction 
A terraform module to create a managed Kubernetes cluster on AWS EKS(Fargate)

# Getting Started
Download and install the latest terraform binary for your operating system from https://terrform.io

*******************************
Versions
K8s: 1.20 ~ 1.25
Helm chart version for aws EFS CSI : 2.2.2 ~ 2.4.6
Helm chart version for aws load balancer controller : 1.3.2 ~ 1.5.4
Helm chart version for app mesh controller : 1.4.4 ~ 1.12.1
Helm chart for kubernetes dashboard : 3.0.1 (needs upgrade)
Helm chart for kubernetes external secrets : 8.5.0 ~ 8.5.5
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
To use the resulting configuration, you must have kubectl installed

kubectl v1.23 is compatible with k8s version 1.25
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
aws eks update-kubeconfig --name eks-meshed-todos-api
kubectl patch deployment coredns -n kube-system --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
(optional) kubectl config set-context --current --namespace=todos-api
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

2. Create eks addon resource
Change into the eks-addons directory and create the resources after EKS Cluster is created successfully as above.

cd eks-addons
terraform init
terraform validate
terraform plan -out <FILENAME2> -var=cluster_name=<CLUSTERNAME> -var=vpc_id=vpc-<ID> 
terraform apply <FILENAME2>

*******************************
####  UPDATE "service_account.yaml" with the value of the output variable named "service_account_role_arn" 
*******************************

3. Deployment
    3.1 Stateless
        cd ../../deployments/kustomize/meshed-todos-api/
        kubectl apply -k overlays/stateless/
        .
        .
        kubectl delete -k overlays/stateless/
    3.2 Stateful
        kubectl get csidriver
        kubectl get po --all-namespaces
        kubectl get po -n appmesh-system
        cd ../../deployments/kustomize/meshed-todos-api
            *********************************************************************************************
            ####  UPDATE "create_storage.yaml" with the value of the output EFS file system id 
            *********************************************************************************************
            kubectl apply -f create_storage.yaml
            kubectl apply -k overlays/statefull/
        kubectl get storageclass
        kubectl get po -n todos-api
        kubectl exec -it <POD> -c <CONTAINER> /bin/bash -n <NS>
        .
        .
        kubectl delete -k overlays/statefull/
        kubectl delete -f create_storage.yaml

4. DELETING the Cluster
First, delete the K8s resources followed by the EKS Cluster

### DELETE add-ons
cd ../../../terraform-infra/eks-addons/
terraform destroy -var=cluster_name=<CLUSTERNAME> -var=vpc_id=<VPCID> -auto-approve

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
kubectl annotate deployment.apps/coredns -n kube-system eks.amazonaws.com/compute-type="ec2"
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### DELETE eks
cd ../eks
terraform destroy -var-file=<FILENAME> -auto-approve



POD Restart
-----------------
1.) kubectl rollout restart
    kubectl rollout restart deployment <deployment_name> -n <namespace>

2.) kubectl scale
    kubectl scale deployment <deployment name> -n <namespace> --replicas=0
    kubectl scale deployment <deployment name> -n <namespace> --replicas=1