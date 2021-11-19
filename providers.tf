locals {
  environment = { for match in regexall("(?P<key>[[:word:]]*)=(?P<value>[[:graph:]]*)\n", file(".env")) : match["key"] => match["value"] }

  localstack_endpoint = "http://${local.environment["LOCALSTACK_HOSTNAME"]}:${local.environment["LOCALSTACK_PORT"]}"
}

provider "aws" {
  access_key = local.environment["AWS_ACCESS_KEY_ID"]
  secret_key = local.environment["AWS_SECRET_ACCESS_KEY"]
  region     = local.environment["AWS_DEFAULT_REGION"]


  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = local.localstack_endpoint

    apigateway     = local.localstack_endpoint
    cloudformation = local.localstack_endpoint
    cloudwatch     = local.localstack_endpoint
    dynamodb       = local.localstack_endpoint
    es             = local.localstack_endpoint
    firehose       = local.localstack_endpoint
    iam            = local.localstack_endpoint
    kinesis        = local.localstack_endpoint
    lambda         = local.localstack_endpoint
    redshift       = local.localstack_endpoint
    route53        = local.localstack_endpoint
    s3             = local.localstack_endpoint
    secretsmanager = local.localstack_endpoint
    ses            = local.localstack_endpoint
    sns            = local.localstack_endpoint
    sqs            = local.localstack_endpoint
    ssm            = local.localstack_endpoint
    stepfunctions  = local.localstack_endpoint
    sts            = local.localstack_endpoint
  }
}
