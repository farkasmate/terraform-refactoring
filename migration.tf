# add_tool_examples
moved {
  from = aws_s3_bucket.lorem
  to   = aws_s3_bucket.example["lorem"]
}

moved {
  from = aws_s3_bucket.ipsum
  to   = aws_s3_bucket.example["ipsum"]
}
