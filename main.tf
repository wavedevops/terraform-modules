module "vpc" {
  source = "./module"
  azs    = ["us-east-1a", "us-east-1b"]
  db_subnets_cidr = ["10.0.4.0/24", "10.0.5.0/24"]
  env = "dev"
  private_subnets_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
  public_subnets_cidr = ["10.0.0.0/24", "10.0.1.0/24"]
  tags = local.tags
  vpc_cidr_block = "10.0.0.0/16"
}
locals {
  tags = {
    business_unit = "ecommerce"
    business_type = "retail"
    project       = "roboshop"
    cost_center   = 100
  }
}
module "vpc_prod" {
  source = "git::https://github.com/wavedevops/terraform-modules.git"
  azs    = ["us-east-1a", "us-east-1b"]
  db_subnets_cidr = ["10.0.4.0/24", "10.0.5.0/24"]
  env = "prod"
  private_subnets_cidr = ["10.0.2.0/24", "10.0.3.0/24"]
  public_subnets_cidr = ["10.0.0.0/24", "10.0.1.0/24"]
  tags = local.tags
  vpc_cidr_block = "10.0.0.0/16"
}
