variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
}

variable "secret_arn" {
  description = "ARN of the Secrets Manager secret the role may access"
  type        = string
}
