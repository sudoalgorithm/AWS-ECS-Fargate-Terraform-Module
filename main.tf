resource "aws_vpc" "ecs_cluster_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.vpc_instance_tenancy

  tags = {
    Name        = var.vpc_name
    environment = var.env
  }
}

resource "aws_subnet" "ecs_cluster_public_subnet" {
  vpc_id = aws_vpc.ecs_cluster_vpc.id

  count_public_subnet_cidrs_list = length(var.public_subnet_cidrs)
  cidr_block                     = element(var.public_subnet_cidrs, count_public_subnet_cidrs_list.index)

  tags = {
    Name        = "Public Subnet ${count_public_subnet_cidrs_list.index + 1}"
    environment = var.env
  }
}

resource "aws_subnet" "ecs_cluster_private_subnet" {
  vpc_id = aws_vpc.ecs_cluster_vpc.id

  count_private_subnet_cidrs_list = length(var.private_subnet_cidrs)
  cidr_block                      = element(var.private_subnet_cidrs, count_private_subnet_cidrs_list.index)

  count_az_list     = length(var.az)
  availability_zone = element(var.az, count_az_list.index)

  tags = {
    Name        = "Private Subnet ${count_private_subnet_cidrs_list.index + 1}"
    environment = var.env
  }
}

resource "aws_internet_gateway" "ecs_cluster_igw" {
  vpc_id = aws_vpc.ecs_cluster_vpc.id

  tags = {
    Name        = var.ecs_cluster_igw_name
    environment = var.env
  }
}

resource "aws_route_table" "secondary_route_table" {
  vpc_id = aws_vpc.ecs_cluster_vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs_cluster_igw.id
  }

  tags = {
    Name        = var.secondary_route_table_name
    environment = var.env
  }
}

resource "aws_route_table_association" "ecs_public_subnet_association" {
  count_public_subnet_cidrs_list = length(var.public_subnet_cidrs)
  subnet_id                      = element(aws_subnet.ecs_cluster_public_subnet[*].id, count_public_subnet_cidrs_list.index)
  route_table_id                 = aws_route_table.secondary_route_table.id
}