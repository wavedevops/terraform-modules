resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
    Terraform = "true"
  }
}

module "subnets" {
  source = "./subnet"
  for_each = var.subnets
  vpc_id      = aws_vpc.main.id
  subnet_cidr_block  = each.value["subnet_cidr_block"]
  azs         = each.value["azs"]
  env         = each.value["env"]
  name        = each.value["name"]
  tags        = each.value["tags"]
}