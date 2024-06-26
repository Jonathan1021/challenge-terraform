provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"

  region      = var.region
  cost_center = var.cost_center
  env         = var.env
  owner       = var.owner

  name            = "pragma"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "ec2_instance" {
  source   = "./ec2-instance"
  for_each = var.instances

  region      = var.region
  cost_center = var.cost_center
  env         = var.env
  owner       = var.owner

  name      = each.value.name
  type      = each.value.type
  subnet_id = each.value.is_public ? module.vpc.public_subnets[0] : module.vpc.private_subnets[0]
}

