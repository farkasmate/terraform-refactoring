output "cidr_block" {
  description = "Main CIDR block"
  value       = var.cidr_block
}

output "id" {
  description = "VPC id"
  value       = aws_vpc.main.id
}

output "subnets" {
  description = "VPC subnets"
  value = {
    private = { for subnet in aws_subnet.private : subnet.availability_zone => subnet.id }
    public  = { for subnet in aws_subnet.public : subnet.availability_zone => subnet.id }
  }
}
