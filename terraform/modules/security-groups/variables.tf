variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Purpose of the security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "allowed_ingress_cidrs" {
  description = "CIDR blocks permitted to connect"
  type        = list(string)
  default     = []
}

variable "allowed_ingress_ports" {
  description = "TCP ports permitted for ingress"
  type        = list(number)
  default     = [443]
}
