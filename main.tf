resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  tags                 = merge(var.tags, { Name = "${var.env}-vpc" })
}
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "${var.env}-public-subnet-${count.index + 1}"
  }
}
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "${var.env}-private-subnet-${count.index + 1}"
  }
}
resource "aws_subnet" "db_subnets" {
  count             = length(var.db_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "${var.env}-db-subnet-${count.index + 1}"
  }
}
