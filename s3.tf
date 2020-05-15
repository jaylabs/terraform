resource "aws_s3_bucket" "bucket1" {
  count  = lookup(local.create_s3, local.environment)
  bucket = "${local.name_prefix}-bucket1"
  acl    = "private"
  region = lookup(local.region, local.environment)
  versioning {
    enabled = true
  }
  tags = local.common_tags
}

resource "aws_s3_bucket" "bucket2" {
  count  = lookup(local.create_s3, local.environment)
  bucket = "${local.name_prefix}-bucket2"
  acl    = "private"
  region = lookup(local.region, local.environment)
  versioning {
    enabled = true
  }
  tags = local.common_tags
}
