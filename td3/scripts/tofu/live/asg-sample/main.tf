provider "aws" { 
region = "us-east-2" 
} 
module "asg" { 
source = "github.com/asmaeoiskhine/devops//td3/tofu/modules/asg" 
name = "sample-app-asg"           
ami_id = "ami-06fdbcd95c2f69da7"        
user_data = filebase64("${path.module}/user-data.sh")    
app_http_port  = 8080 
instance_type = t3.micro
min_size = 1
max_size = 10     
desired_capacity = 3 
}
