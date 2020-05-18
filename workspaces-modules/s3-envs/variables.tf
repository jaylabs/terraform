locals {
  create_s3 = {
    "development" = 1
    "qa"          = 0
    "staging"     = 0
    "production"  = 0
  }
}

locals {
  environment = "${terraform.workspace}"
}

variable "bucket" {
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "region" {
  type        = string
  default     = null
}
