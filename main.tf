resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/22"
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.0.0/24"
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-west-1b"
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-west-1c"
  cidr_block        = "10.0.2.0/24"
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.3.0/26"
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-west-1b"
  cidr_block        = "10.0.3.64/26"
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "eu-west-1c"
  cidr_block        = "10.0.3.128/26"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "nat" {
  vpc = true

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "a" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.a.id
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private.id
}
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "ruby_lambda/lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256("ruby_lambda/lambda_function_payload.zip")

  runtime = "ruby2.7"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_s3_bucket" "lorem" {
  bucket = "example-lorem"
  acl    = "private"
}

resource "aws_s3_bucket" "ipsum" {
  bucket = "example-ipsum"
  acl    = "private"
}
