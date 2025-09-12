resource "aws_subnet" "main" {
  count             = length(var.subnet_cidr_block)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(var.tags, {
    Name = "${var.env}-${var.name}-subnet-${count.index + 1}"
  })
}