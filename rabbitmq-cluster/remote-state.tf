terraform {
  backend "s3" {
    encrypt = true
    bucket  = "terraform-remote-state-jaylabs-dev"
    region  = "us-east-1"
    key     = "terraform/rabbitmq-cluster-dev.tfstate"
  }
}
