output "ec2_id" {
  description = "The ID of the ec2"
  value       = aws_instance.this.id
}

output "ec2_arn" {
  description = "The ARN of the ec2"
  value       = aws_instance.this.arn
}

output "ec2_public_ip" {
  description = "The public ip of the ec2"
  value       = aws_instance.this.public_ip
}

output "ec2_private_ip" {
  description = "The private ip of the ec2"
  value       = aws_instance.this.private_ip
}
