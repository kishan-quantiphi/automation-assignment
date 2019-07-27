output "subnet_id" {
  description = "ID of subnet"
  value       = aws_subnet.this.id
}

output "subnet_arn" {
  description = "ARN of subnet"
  value       = aws_subnet.this.arn
}

output "subnet_cidr" {
  description = "CIDR of subnet"
  value       = aws_subnet.this.cidr_block
}