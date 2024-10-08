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