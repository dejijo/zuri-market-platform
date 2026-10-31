output "vpc_id" {
  description = "ID of the selected VPC"
  value       = data.aws_vpc.selected.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the selected VPC"
  value       = data.aws_vpc.selected.cidr_block
}

output "subnet_ids" {
  description = "Subnet IDs belonging to the selected VPC"
  value       = data.aws_subnets.selected.ids
}
