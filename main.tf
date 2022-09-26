locals {
  bucket_list_lambda = "lambda/bucket-list/gen/lambda_function_payload.zip"
  example_buckets    = ["lorem", "ipsum"]
}

module "vpc" {
  source = "./modules/vpc"
}

data "aws_iam_policy_document" "assume_lambda" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "bucket_list" {
  name = "bucket-list"

  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
}

resource "aws_lambda_function" "bucket_list" {
  filename      = local.bucket_list_lambda
  function_name = "bucket-list"
  role          = aws_iam_role.bucket_list.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = filebase64sha256(local.bucket_list_lambda)

  runtime = "ruby2.7"

  environment {
    variables = {
      LOCALSTACK_PORT = data.dotenv.localstack.env["LOCALSTACK_PORT"]
    }
  }
}

resource "aws_s3_bucket" "example" {
  for_each = toset(local.example_buckets)

  bucket = "example-${each.value}"
}

resource "aws_s3_bucket_acl" "example_acl" {
  for_each = toset(local.example_buckets)

  bucket = aws_s3_bucket.example[each.value].id
  acl    = "private"
}
