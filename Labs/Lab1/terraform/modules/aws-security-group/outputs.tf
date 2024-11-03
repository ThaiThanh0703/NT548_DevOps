output "security_group_arn" {
  description = "The ARN of the security group"
  value       = try(aws_security_group.this.arn, "")
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this.id,"")
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = try(aws_security_group.this.vpc_id,  "")
}

output "security_group_owner_id" {
  description = "The owner ID"
  value       = try(aws_security_group.this.owner_id, "")
}

output "security_group_name" {
  description = "The name of the security group"
  value       = try(aws_security_group.this.name, "")
}

output "security_group_description" {
  description = "The description of the security group"
  value       = try(aws_security_group.this.description,"")
}
