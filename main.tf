module "vpc" {
  source = "./modules/vpc"
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
