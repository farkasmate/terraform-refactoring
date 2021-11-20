variable "cidr_block" {
  description = "Main CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.cidr_block))
    error_message = "Invalid CIDR block."
  }
}
