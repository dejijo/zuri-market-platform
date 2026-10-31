module "network" {
  source = "../../modules/network"

  aws_region = var.aws_region
  vpc_id     = var.vpc_id
}

module "security_groups" {
  source = "../../modules/security-groups"

  name        = "zuri-market-dev-app"
  description = "Restricted security group for Zuri Market development node"
  vpc_id      = var.vpc_id

  allowed_ingress_ports = [22]
  allowed_ingress_cidrs = [var.admin_cidr]
}

