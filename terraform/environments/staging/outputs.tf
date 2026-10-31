output "vpc_id" {
  description = "Existing VPC used by the staging environment"
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
