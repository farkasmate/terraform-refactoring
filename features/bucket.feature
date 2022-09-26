Feature: AWS S3 Buckets are compliant
  S3 Buckets must follow guidelines.

  Scenario: Buckets are encrypted (v4)
    Given I have aws_s3_bucket_server_side_encryption_configuration defined
    Then it must have bucket
    Given I have aws_s3_bucket defined
    Then it must have bucket
    And it must be in {aws_s3_bucket_server_side_encryption_configuration.values.bucket}

  Scenario: Buckets are prefixed as 'example-'
    Given I have aws_s3_bucket defined
    Then it must have bucket
    And its value must match the "^example-.*$" regex
