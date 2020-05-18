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
    profile = "default"
  }
}

module "vpc" {
  source  = "./modules/vpc"
  name = "${lookup(local.env_name, local.environment)}-${lookup(local.env_type, local.environment)}"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "${lookup(local.profile, local.environment)}"
  }  
}

module "s3" {
  source = "./modules/s3"

  bucket = "${local.app_name}-${lookup(local.env_name, local.environment)}-${lookup(local.env_type, local.environment)}-${lookup(local.region, local.environment)}"
  acl    = "private"

  versioning = {
    enabled = true
  }
}

module "s3-envs" {
  source = "./modules/s3-envs"
  
  bucket = "${local.app_name}-${lookup(local.env_name, local.environment)}-${lookup(local.env_type, local.environment)}-${lookup(local.region, local.environment)}"
  
  tags = local.common_tags
}
