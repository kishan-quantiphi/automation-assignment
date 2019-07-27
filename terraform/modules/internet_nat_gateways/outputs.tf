output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "nat_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "nat_dependency" {
  description = "Hack for reources which depend on NAT"
  value       = null_resource.dummy_dependency.id
}