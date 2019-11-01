provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "terraform-bless"
    key = "bless/terraform.tfstate"
    region = "ap-southeast-1"
    encrypt = true
  }
}

module "vpc" {
  source = "./vpc"
}

// Bastion Setup for our infrastructure
module "bastion" {
  source = "../../management/bastion-hosts"
  vpc_id = module.vpc.vpc_id
}

// Bless Module Will be created as part of our platform tooling
module "bless" {
  source = "git@github.com:kshitijcode/blessMe.git//terraform//environments//prod"
  region = var.region
}

