output "rds_id" {
  description = "The ID of the rds instance"
  value       = aws_db_instance.this.id
}

output "rds_arn" {
  description = "The ARN of the rds instance"
  value       = aws_db_instance.this.arn
}

output "rds_endpoint" {
  description = "The endpoint of the rds"
  value       = aws_db_instance.this.endpoint
}
