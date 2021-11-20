locals {
  bucket_list_lambda = "lambda/bucket-list/gen/lambda_function_payload.zip"
  example_buckets    = ["lorem", "ipsum"]
}

module "vpc" {
  source = "./modules/vpc"
}

module "bucket_list" {
  source = "./vendor/modules/lambda"

  create_package         = false
  local_existing_package = "lambda/bucket-list/gen/lambda_function_payload.zip"

  function_name = "bucket-list"
  handler       = "lambda_function.lambda_handler"

  runtime = "ruby2.7"

  environment_variables = {
    LOCALSTACK_PORT = data.dotenv.localstack.env["LOCALSTACK_PORT"]
  }
}

#tfsec:ignore:aws-s3-enable-versioning
resource "aws_s3_bucket" "example" {
  for_each = toset(local.example_buckets)

  bucket = "example-${each.value}"
}

resource "aws_s3_bucket_acl" "example_acl" {
  for_each = toset(local.example_buckets)

  bucket = aws_s3_bucket.example[each.value].id
  acl    = "private"
}
