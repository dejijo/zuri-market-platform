variable "aws_region" {
  description = "AWS region for the development environment"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_id" {
  description = "Existing default VPC ID in London"
  type        = string
  default     = "vpc-05e6d35fc5619d514"
}

variable "admin_cidr" {
  description = "Public IPv4 CIDR allowed to SSH to the development node"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the development Kubernetes node"
  type        = string
  default     = "t3.small"
}
