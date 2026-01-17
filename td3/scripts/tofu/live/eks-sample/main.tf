provider "aws" {
  region = "us-east-1"
}

module "cluster" {
  source = "github.com/asmaeoiskhine/devops_base//ch3/tofu/modules/eks-cluster"

  name        = "eks-sample"        
  eks_version = "1.29"              

  instance_type        = "t3.micro" 
  min_worker_nodes     = 1          
  max_worker_nodes     = 10         
  desired_worker_nodes = 3          
}
