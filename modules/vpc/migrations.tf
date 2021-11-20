# NOTE: The migration must use static values
moved {
  from = aws_subnet.private_a
  to   = aws_subnet.private["eu-west-1a"]
}

moved {
  from = aws_subnet.private_b
  to   = aws_subnet.private["eu-west-1b"]
}

moved {
  from = aws_subnet.private_c
  to   = aws_subnet.private["eu-west-1c"]
}

moved {
  from = aws_subnet.public_a
  to   = aws_subnet.public["eu-west-1a"]
}

moved {
  from = aws_subnet.public_b
  to   = aws_subnet.public["eu-west-1b"]
}

moved {
  from = aws_subnet.public_c
  to   = aws_subnet.public["eu-west-1c"]
}

moved {
  from = aws_route_table_association.private_a
  to   = aws_route_table_association.private["eu-west-1a"]
}

moved {
  from = aws_route_table_association.private_b
  to   = aws_route_table_association.private["eu-west-1b"]
}

moved {
  from = aws_route_table_association.private_c
  to   = aws_route_table_association.private["eu-west-1c"]
}

moved {
  from = aws_route_table_association.public_a
  to   = aws_route_table_association.public["eu-west-1a"]
}

moved {
  from = aws_route_table_association.public_b
  to   = aws_route_table_association.public["eu-west-1b"]
}

moved {
  from = aws_route_table_association.public_c
  to   = aws_route_table_association.public["eu-west-1c"]
}
