resource "aws_s3_bucket" "bucket" {
  count  = lookup(local.create_s3, local.environment)
  bucket = var.bucket
  acl    = "private"
  region = var.region
  versioning {
    enabled = true
  }
  tags = var.tags
}
