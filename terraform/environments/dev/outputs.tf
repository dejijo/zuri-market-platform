output "vpc_id" {
  description = "Existing VPC used by the development environment"
  value       = module.network.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the existing VPC"
  value       = module.network.vpc_cidr_block
}

output "subnet_ids" {
  description = "Existing subnet IDs discovered in the VPC"
  value       = module.network.subnet_ids
}

output "kubernetes_instance_id" {
  description = "EC2 instance ID for the development Kubernetes node"
  value       = aws_instance.kubernetes_node.id
}

output "kubernetes_public_ip" {
  description = "Public IPv4 address of the development Kubernetes node"
  value       = aws_instance.kubernetes_node.public_ip
}

output "kubernetes_public_dns" {
  description = "Public DNS name of the development Kubernetes node"
  value       = aws_instance.kubernetes_node.public_dns
}
