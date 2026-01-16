#!/usr/bin/env bash
set -e
export AWS_DEFAULT_REGION="us-east-1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
user_data=$(cat "$SCRIPT_DIR/user-data.sh")

# Create a security group
security_group_id=$(aws ec2 create-security-group --group-name "sample-app" --description "Allow HTTP traffic into the >

# Allow inbound HTTP traffic
aws ec2 authorize-security-group-ingress --group-id "$security_group_id" --protocol tcp --port 8080 --cidr "0.0.0.0/0" >

# Launch the EC2 instance
instance_id=$(aws ec2 run-instances --image-id "ami-0900fe555666598a2" --instance-type "t3.micro" --security-group-ids >

# Wait for the instance to be in running state
aws ec2 wait instance-running --instance-ids "$instance_id"

# Get the public IP address
public_ip=$(aws ec2 describe-instances --instance-ids "$instance_id" --output text --query 'Reservations[*].Instances[*>

echo "Instance ID = $instance_id"
echo "Security Group ID = $security_group_id"
echo "Public IP = $public_ip"
