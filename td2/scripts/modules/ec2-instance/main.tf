provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sample_app" {
  name        = var.name
  description = "Allow HTTP traffic into the sample app"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = var.port
  to_port           = var.port
  security_group_id = aws_security_group.sample_app.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Déploiement de plusieurs instances avec count
resource "aws_instance" "sample_app" {
  count                  = 3   # 3 instances
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sample_app.id]
  user_data              = file("${path.module}/user-data.sh")

  tags = {
    Name = var.name  # Nom unique par instance
    Test = "update"
  }
}
