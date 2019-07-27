output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "ec2_public_ip" {
  description = "Public IP of public EC2"
  value       = module.public_ec2.ec2_public_ip
}

output "ec2_private_ip" {
  description = "Private IP of private EC2"
  value       = module.private_ec2.ec2_private_ip
}

output "private_rds_id" {
  description = "ID of RDS instance"
  value       = module.private_rds.rds_id
}

output "private_rds_endpoint" {
  description = "Endpoint of RDS instance"
  value       = module.private_rds.rds_endpoint
}
