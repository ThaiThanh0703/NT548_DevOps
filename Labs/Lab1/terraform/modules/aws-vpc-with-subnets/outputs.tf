################################################################################
# VPC
################################################################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.this[0].id, null)
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.this[0].arn, null)
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.this[0].cidr_block, null)
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = try(aws_vpc.this[0].default_security_group_id, null)
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = try(aws_vpc.this[0].default_network_acl_id, null)
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = try(aws_vpc.this[0].default_route_table_id, null)
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = try(aws_vpc.this[0].owner_id, null)
}

################################################################################
# Public Subnets
################################################################################

output "public_subnet_ids" {  
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public[*].arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public[*].cidr_block)
}

################################################################################
# Private Subnets
################################################################################

output "private_subnet_ids" {  
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private[*].arn
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.private[*].cidr_block)
}

################################################################################
# Default Security Group
################################################################################

output "default_sg_id" {
  description = "The ID of the default security group"
  value       = aws_security_group.default[0].id  
}

output "default_sg_name" {
  description = "The name of the default security group"
  value       = aws_security_group.default[0].name  
}

output "default_sg_description" {
  description = "The description of the default security group"
  value       = aws_security_group.default[0].description  
}

################################################################################
# Internet Gateway
################################################################################

output "internet_gateway" {  
  description = "The name of the Internet Gateway"
  value       = try(aws_internet_gateway.this[0], null) 
}

output "igw_id" {  
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.this[0].id, null)  
}