data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "kubernetes_node_ssm" {
  name               = "zuri-market-dev-kubernetes-ssm"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {
    Name      = "zuri-market-dev-kubernetes-ssm"
    Project   = "zuri-market"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role       = aws_iam_role.kubernetes_node_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "kubernetes_node" {
  name = "zuri-market-dev-kubernetes-profile"
  role = aws_iam_role.kubernetes_node_ssm.name

  tags = {
    Project   = "zuri-market"
    ManagedBy = "Terraform"
  }
}
