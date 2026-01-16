provider "aws" { 
region = "us-east-1" 
} 

module "sample_app_1" {
source = "github.com/asmaeoiskhine/devops.git//td2/scripts/modules/ec2-instance" 
ami_id = "ami-0b306fbb0d2a216ed"  # Replace with your AMI ID 
name   = "sample-app-from-github"
instance_type = "t3.micro"
port = 8080 
}

