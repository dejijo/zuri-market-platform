terraform {
  backend "s3" {
    bucket       = "zuri-market-terraform-state-831975836249"
    key          = "zuri-market/staging/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
