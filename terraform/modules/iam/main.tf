data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    ManagedBy = "Terraform"
  }
}

data "aws_iam_policy_document" "read_secret" {
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [var.secret_arn]
  }
}

resource "aws_iam_policy" "read_secret" {
  name        = var.policy_name
  description = "Allow reading the designated Zuri Market secret"
  policy      = data.aws_iam_policy_document.read_secret.json
}

resource "aws_iam_role_policy_attachment" "read_secret" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.read_secret.arn
}
