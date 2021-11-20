/**
 * Example VPC module
 */
locals {
  subnet_cidrs       = cidrsubnets(var.cidr_block, 2, 2, 2, 4, 4, 4)
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)

  availability_zone_letters = [ for az in local.availability_zones : substr(az, -1, 1) ]

  private_cidrs = zipmap(local.availability_zone_letters, slice(local.subnet_cidrs, 0, 3))
  public_cidrs  = zipmap(local.availability_zone_letters, slice(local.subnet_cidrs, 3, 6))
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "private" {
  for_each = local.private_cidrs

  vpc_id            = aws_vpc.main.id
  availability_zone = "${data.aws_availability_zones.available.id}${each.key}"
  cidr_block        = each.value
}

resource "aws_subnet" "public" {
  for_each = local.public_cidrs

  vpc_id            = aws_vpc.main.id
  availability_zone = "${data.aws_availability_zones.available.id}${each.key}"
  cidr_block        = each.value
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "nat" {
  vpc = true

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[local.availability_zone_letters[0]].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "private" {
  for_each = toset(local.availability_zone_letters)

  subnet_id      = aws_subnet.private[each.value].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  for_each = toset(local.availability_zone_letters)

  subnet_id      = aws_subnet.public[each.value].id
  route_table_id = aws_route_table.public.id
}
