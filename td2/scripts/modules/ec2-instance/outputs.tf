output "instance_ids" {
  description = "The IDs of the EC2 instances"
  value       = [for inst in aws_instance.sample_app : inst.id]
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.sample_app.id
}

output "public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = [for inst in aws_instance.sample_app : inst.public_ip]
}
