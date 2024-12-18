################################################################################
# EC2 Instance
################################################################################
output "id" {
  description = "The ID of the instance"
  value = try(
    aws_instance.this[0].id,
    null,
  )
}

output "arn" {
  description = "The ARN of the instance"
  value = try(
    aws_instance.this[0].arn,
    null,
  )
}

output "instance_state" {
  description = "The state of the instance"
  value = try(
    aws_instance.this[0].instance_state,
    null,
  )
}


output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value = try(
    aws_instance.this[0].tags_all,
    {},
  )
}

output "ami" {
  description = "AMI ID that was used to create the instance"
  value = try(
    aws_instance.this[0].ami,
    null,
  )
}

output "availability_zone" {
  description = "The availability zone of the created instance"
  value = try(
    aws_instance.this[0].availability_zone,
    null,
  )
}
