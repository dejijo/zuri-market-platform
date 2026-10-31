variable "aws_region" {
  description = "AWS region for the staging environment"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_id" {
  description = "Existing VPC used by staging"
  type        = string
  default     = "vpc-05e6d35fc5619d514"
}
