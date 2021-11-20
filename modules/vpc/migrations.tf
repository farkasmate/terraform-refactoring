# NOTE: The migration must use static values
moved {
  from = aws_subnet.private_a
  to   = aws_subnet.private["a"]
}

moved {
  from = aws_subnet.private_b
  to   = aws_subnet.private["b"]
}

moved {
  from = aws_subnet.private_c
  to   = aws_subnet.private["c"]
}

moved {
  from = aws_subnet.public_a
  to   = aws_subnet.public["a"]
}

moved {
  from = aws_subnet.public_b
  to   = aws_subnet.public["b"]
}

moved {
  from = aws_subnet.public_c
  to   = aws_subnet.public["c"]
}

moved {
  from = aws_route_table_association.private_a
  to   = aws_route_table_association.private["a"]
}

moved {
  from = aws_route_table_association.private_b
  to   = aws_route_table_association.private["b"]
}

moved {
  from = aws_route_table_association.private_c
  to   = aws_route_table_association.private["c"]
}

moved {
  from = aws_route_table_association.public_a
  to   = aws_route_table_association.public["a"]
}

moved {
  from = aws_route_table_association.public_b
  to   = aws_route_table_association.public["b"]
}

moved {
  from = aws_route_table_association.public_c
  to   = aws_route_table_association.public["c"]
}
