module "network" {
  source = "../../modules/network"

  aws_region = var.aws_region
  vpc_id     = var.vpc_id
}
