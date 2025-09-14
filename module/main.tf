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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = merge(var.tags, { Name = "${var.env}-igw" })
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = merge(var.tags, { Name = "${var.env}-Rt-public" })
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = merge(var.tags, { Name = "${var.env}-Rt-private" })
  }
}
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = merge(var.tags, { Name = "${var.env}-Rt-db" })
  }
}

resource "aws_route" "public" {
  count = length(aws_subnet.public_subnets)
  route_table_id            = aws_route_table.public.id[count.index]
  destination_cidr_block    = "0.0.0.0"
  gateway_id = aws_internet_gateway.igw.id
}
resource "aws_route" "private" {
  count = length(aws_subnet.private_subnets)
  route_table_id            = aws_route_table.public.id[count.index]
  destination_cidr_block    = "0.0.0.0"
  gateway_id = aws_internet_gateway.igw.id

}
resource "aws_route" "db" {
  count = length(aws_subnet.db_subnets)
  route_table_id            = aws_route_table.public.id[count.index]
  destination_cidr_block    = "0.0.0.0"
  gateway_id = aws_internet_gateway.igw.id
}
