locals {
  app_name       = "my-app"
  project_name   = "my-project"
  profile_prefix = "jaylabs"
}

locals {
  profile = {
    "development" = "${local.profile_prefix}-development"
    "qa"          = "${local.profile_prefix}-qa"
    "staging"     = "${local.profile_prefix}-staging"
    "production"  = "${local.profile_prefix}-production"
  }

  env_type = {
    "development" = "dev"
    "qa"          = "qa"
    "staging"     = "stg"
    "production"  = "prd"
  }

    env_name = {
    "development" = "name1"
    "qa"          = "name2"
    "staging"     = "name3"
    "production"  = "name4"
  }

  region = {
    "development" = "us-east-1"
    "qa"          = "us-east-1"
    "staging"     = "us-east-1"
    "production"  = "us-east-1"
  }
}

locals {
  environment = "${terraform.workspace}"
}

locals {
  common_tags = {
    Terraform   = "true"
    Environment = local.environment
  }
  name_suffix = "${local.app_name}-${local.environment}"
}