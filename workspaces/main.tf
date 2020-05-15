provider "aws" {
  version = "~> 2.28"
  profile = lookup(local.profile, local.environment)
  region  = lookup(local.region, local.environment)
}

terraform {
  required_version = "~> 0.12"
  backend "s3" {
    encrypt = true
    bucket  = "terraform-remote-state"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "jaylabs-development"
  }
}
