variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "instance_count" {
  default = "2"
}

variable "environment" {
  default = "Dev"
}

variable "instance_name" {
  default = "rabbitmq-cluster-dev"
}

variable "dns_address" {
  default = "rabbitmq-cluster.dev.jaylabs.io"
}

variable "bastion_address" {
  default = "bastion.dev.jaylabs.io"
}

variable "vpc-jaylabs-dev" {
  default = "vpc-xxxxxx"
}

variable "sg-jaylabs-dev" {
  default = "sg-xxxxx"

}

variable "subnet_ids" {
  default = ["subnet-xxxxx", "subnet-yyyyy"]
}

variable "az_ids" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "amis" {
  type = map

  default = {
    "ami-al2-us-east-1"    = "ami-00068cd7555f543d5" # Amazon Linux 2 - N. Virginia
    "ami-ubuntu-us-east-1" = "ami-04b9e92b5572fa0d1" # Ubuntu Server 18.04 - N. Virginia
  }
}


variable "key-jaylabs-dev" {
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "ansible_user" {
  default = "ubuntu"
}

variable "private_key" {
  default = "./keys/jaylabs-dev-us-east-1_rsa"
}
