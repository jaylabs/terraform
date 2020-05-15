locals {
  app_name       = "my_app"
  profile_prefix = "jaylabs"
}

locals {
  profile = {
    "development" = "${local.profile_prefix}-development"
    "qa"          = "${local.profile_prefix}-qa"
    "staging"     = "${local.profile_prefix}-staging"
    "production"  = "${local.profile_prefix}-production"
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
  name_prefix = "${local.app_name}-${local.environment}"
}
