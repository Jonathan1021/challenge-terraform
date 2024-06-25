terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "vpc" {
  source = "./vpc"

  region      = "us-east-1"
  cost_center = "pragma"
  env         = "dev"
  owner       = "Jonathan Vega"

  name            = "pragma"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "ec2_instance" {
  source = "./ec2-instance"

  region      = "us-east-1"
  cost_center = "pragma"
  env         = "dev"
  owner       = "Jonathan Vega"
  subnet_id   = module.vpc.public_subnets[0]
}

