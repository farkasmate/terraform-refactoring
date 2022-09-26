# vim: set syntax=tf:

plugin "terraform" {
  preset  = "all"
  enabled = true
}

plugin "aws" {
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  version = "0.17.0"
  enabled = true
}
