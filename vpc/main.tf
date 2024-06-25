provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block       = var.cidr
  instance_tenancy = var.instance_tenancy

  tags = {
    Name       = "${var.env}-vpc-${var.name}"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}


# Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(concat(var.public_subnets, [""]), count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name       = "${var.env}-sb-public-${element(var.azs, count.index)}"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name       = "${var.env}-ig"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name       = "${var.env}-rtb-public"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# # Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(concat(var.private_subnets, [""]), count.index)
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name       = "${var.env}-sb-private-${element(var.azs, count.index)}"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name       = "${var.env}-eip"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}

resource "aws_nat_gateway" "this" {
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.nat.id
  tags = {
    Name       = "${var.env}-nat-gateway"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name       = "${var.env}-rtb-private"
    Owner      = var.owner
    Enviroment = var.env
    CostCenter = var.cost_center
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}