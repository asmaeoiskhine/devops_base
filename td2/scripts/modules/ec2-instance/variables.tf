variable "ami_id" {
  description = "The ID of the AMI to run."
  type        = string
}

variable "name" {
  description = "The base name for the instance and all other resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "port" {
  description = "The port on which the app listens"
  type        = number
}
