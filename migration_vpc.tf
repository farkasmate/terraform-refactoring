moved {
  from = aws_vpc.main
  to   = module.vpc.aws_vpc.main
}

moved {
  from = aws_subnet.private_a
  to   = module.vpc.aws_subnet.private_a
}

moved {
  from = aws_subnet.private_b
  to   = module.vpc.aws_subnet.private_b
}

moved {
  from = aws_subnet.private_c
  to   = module.vpc.aws_subnet.private_c
}

moved {
  from = aws_subnet.public_a
  to   = module.vpc.aws_subnet.public_a
}

moved {
  from = aws_subnet.public_b
  to   = module.vpc.aws_subnet.public_b
}

moved {
  from = aws_subnet.public_c
  to   = module.vpc.aws_subnet.public_c
}

moved {
  from = aws_internet_gateway.gw
  to   = module.vpc.aws_internet_gateway.gw
}

moved {
  from = aws_eip.nat
  to   = module.vpc.aws_eip.nat
}

moved {
  from = aws_nat_gateway.a
  to   = module.vpc.aws_nat_gateway.a
}

moved {
  from = aws_route_table.public
  to   = module.vpc.aws_route_table.public
}

moved {
  from = aws_route_table.private
  to   = module.vpc.aws_route_table.private
}

moved {
  from = aws_route_table_association.public_a
  to   = module.vpc.aws_route_table_association.public_a
}

moved {
  from = aws_route_table_association.public_b
  to   = module.vpc.aws_route_table_association.public_b
}

moved {
  from = aws_route_table_association.public_c
  to   = module.vpc.aws_route_table_association.public_c
}

moved {
  from = aws_route_table_association.private_a
  to   = module.vpc.aws_route_table_association.private_a
}

moved {
  from = aws_route_table_association.private_b
  to   = module.vpc.aws_route_table_association.private_b
}

moved {
  from = aws_route_table_association.private_c
  to   = module.vpc.aws_route_table_association.private_c
}
