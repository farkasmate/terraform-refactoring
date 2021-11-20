# add_tool_examples
moved {
  from = aws_s3_bucket.lorem
  to   = aws_s3_bucket.example["lorem"]
}

moved {
  from = aws_s3_bucket.ipsum
  to   = aws_s3_bucket.example["ipsum"]
}


# Migrate bucket-list lambda to terraform-aws-modules/lambda/aws
moved {
  from = aws_iam_role.bucket_list
  to   = module.bucket_list.aws_iam_role.lambda[0]
}

moved {
  from = aws_lambda_function.bucket_list
  to   = module.bucket_list.aws_lambda_function.this[0]
}
