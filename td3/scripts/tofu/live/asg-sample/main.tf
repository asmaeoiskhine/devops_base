provider "aws" { 
region = "us-east-1" 
} 
module "asg" { 
source = "github.com/asmaeoiskhine/devops_base//td3/scripts/tofu/modules/asg" 
name = "sample-app-asg"           
ami_id = "ami-0ea4e0bac1b7f3d9d"        
user_data = filebase64("${path.module}/user-data.sh")    
app_http_port  = 8080 
instance_type = "t3.micro"
min_size = 1
max_size = 10     
desired_capacity = 3 
key_name = "ansible-ch3"
target_group_arns = [module.alb.target_group_arn]
}

module "alb" {
source = "github.com/asmaeoiskhine/devops_base//td3/scripts/tofu/modules/alb"
name = "sample-app-alb"
alb_http_port = 80
app_http_port = 8080
app_health_check_path = "/health"

}
