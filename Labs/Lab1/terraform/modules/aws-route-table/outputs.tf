locals {
  public_route_table_ids   = aws_route_table.public[*].id
  private_route_table_ids  = aws_route_table.private[*].id
}

################################################################################
# Publiс Route Table
################################################################################
output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = local.public_route_table_ids
}
output "public_route_table_association_ids" {
  description = "List of IDs of the public route table association"
  value       = aws_route_table_association.public[*].id
}

################################################################################
# Private Route Table
################################################################################
output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = local.private_route_table_ids
}

output "private_route_table_association_ids" {
  description = "List of IDs of the private route table association"
  value       = aws_route_table_association.private[*].id
}
