output "igw_route_table_id" {
  description = "The ID of the Route Table"
  value       = aws_route_table.igw_rt[0].id
}

output "nat_route_table_id" {
  description = "The ID of the Route Table"
  value       = aws_route_table.nat_rt[0].id
}