###################################
# VPC
###################################
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = merge(
    var.tags,
    { Name = "${var.env}-vpc" }
  )
}

###################################
# Subnets
###################################
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    var.tags,
    { Name = "${var.env}-public-subnet-${count.index + 1}" }
  )
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    var.tags,
    { Name = "${var.env}-private-subnet-${count.index + 1}" }
  )
}

resource "aws_subnet" "db_subnets" {
  count             = length(var.db_subnets_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnets_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    var.tags,
    { Name = "${var.env}-db-subnet-${count.index + 1}" }
  )
}

###################################
# Internet Gateway
###################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    { Name = "${var.env}-igw" }
  )
}

###################################
# Route Tables
###################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    { Name = "${var.env}-rt-public" }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    { Name = "${var.env}-rt-private" }
  )
}

resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    { Name = "${var.env}-rt-db" }
  )
}

###################################
# Routes
###################################
# Public subnets go via IGW
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private + DB usually go via NAT Gateway (not IGW)
# Leave empty or add NAT later

###################################
# Route Table Associations
###################################
# resource "aws_route_table_association" "public" {
#   count          = length(aws_subnet.public_subnets)
#   subnet_id      = aws_subnet.public_subnets[count.index].id
#   route_table_id = aws_route_table.public.id
# }
#
# resource "aws_route_table_association" "private" {
#   count          = length(aws_subnet.private_subnets)
#   subnet_id      = aws_subnet.private_subnets[count.index].id
#   route_table_id = aws_route_table.private.id
# }
#
# resource "aws_route_table_association" "db" {
#   count          = length(aws_subnet.db_subnets)
#   subnet_id      = aws_subnet.db_subnets[count.index].id
#   route_table_id = aws_route_table.db.id
# }
