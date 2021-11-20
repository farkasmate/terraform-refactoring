locals {
  localstack_endpoint = "http://${data.dotenv.localstack.env["LOCALSTACK_HOSTNAME"]}:${data.dotenv.localstack.env["LOCALSTACK_PORT"]}"
}

terraform {
  required_version = "~> 1.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.66"
    }
    dotenv = {
      source  = "jrhouston/dotenv"
      version = "~> 1.0"
    }
  }
}

data "dotenv" "localstack" {
  filename = ".env"
}

provider "aws" {
  access_key = data.dotenv.localstack.env["AWS_ACCESS_KEY_ID"]
  secret_key = data.dotenv.localstack.env["AWS_SECRET_ACCESS_KEY"]
  region     = data.dotenv.localstack.env["AWS_DEFAULT_REGION"]

  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    cloudwatchlogs = local.localstack_endpoint
    ec2            = local.localstack_endpoint
    iam            = local.localstack_endpoint
    lambda         = local.localstack_endpoint
    s3             = local.localstack_endpoint
  }
}
