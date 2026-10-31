resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = {
      for pair in setproduct(
        var.allowed_ingress_ports,
        var.allowed_ingress_cidrs
      ) : "${pair[0]}-${pair[1]}" => pair
    }

    content {
      description = "Configured inbound TCP access"
      from_port   = ingress.value[0]
      to_port     = ingress.value[0]
      protocol    = "tcp"
      cidr_blocks = [ingress.value[1]]
    }
  }

  egress {
    description = "Outbound IPv4 connectivity"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = var.name
    ManagedBy = "Terraform"
  }
}
