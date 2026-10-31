resource "aws_instance" "kubernetes_node" {
  ami           = "ami-057b46c043e81dcf4"
  instance_type = var.instance_type
  subnet_id     = module.network.subnet_ids[0]
  user_data     = file("${path.module}/bootstrap.sh")


  vpc_security_group_ids      = [module.security_groups.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.kubernetes_node.name
  # Public IP retained for development; SSH ingress is restricted to var.admin_cidr.
  associate_public_ip_address = true # NOSONAR


  root_block_device {
    volume_size           = 12
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name      = "zuri-market-dev-kubeadm"
    Project   = "zuri-market"
    ManagedBy = "Terraform"
  }
}
