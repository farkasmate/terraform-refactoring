<!-- DO NOT EDIT MANUALLY
To update run:
  docker run --rm --volume "${PWD}:/terraform-docs:rw" quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs
-->
<!-- BEGIN_TF_DOCS -->
Example VPC module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | Main CIDR block for the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cidr_block"></a> [cidr\_block](#output\_cidr\_block) | Main CIDR block |
| <a name="output_id"></a> [id](#output\_id) | VPC id |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | VPC subnets |
<!-- END_TF_DOCS -->
