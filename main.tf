resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block

  tags = {
    Name = "${var.env}-vpc"
    Terraform = "true"
  }
}

module "subnets" {
  source = "./subnets"

  for_each   = var.subnets
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value["cidr_block"]
  name       = each.value["name"]
  azs        = each.value["azs"]

  tags = var.tags
  env  = var.env
}