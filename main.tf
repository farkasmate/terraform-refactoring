locals {
  bucket_list_lambda = "lambda/bucket-list/gen/lambda_function_payload.zip"
}

module "vpc" {
  source = "./modules/vpc"
}

data "aws_iam_policy_document" "iam_for_lambda" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = data.aws_iam_policy_document.iam_for_lambda.json
}

resource "aws_lambda_function" "bucket_list" {
  filename      = local.bucket_list_lambda
  function_name = "bucket-list"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256(local.bucket_list_lambda)

  runtime = "ruby2.7"

  environment {
    variables = {
      LOCALSTACK_PORT = data.dotenv.localstack.env["LOCALSTACK_PORT"]
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
