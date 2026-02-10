terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}


module "application" {
  source            = ".//application"
  sgs               = module.network_security.sg_ids
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.subnet_ids
  instance_type     = var.instance_type
}

module "network" {
  source              = ".//network"
  allowed_ip_range    = var.allowed_ip_range
  project_name        = var.project_name
  public_subnet_azs   = var.public_subnet_azs
  public_subnet_cidrs = var.public_subnet_cidrs
  vpc_cidr            = var.vpc_cidr
}

module "network_security" {
  source           = ".//network_security"
  vpc_id           = module.network.vpc_id
  allowed_ip_range = var.allowed_ip_range
  project_name     = var.project_name
  sg_ingress_rules = var.sg_ingress_rules
}
