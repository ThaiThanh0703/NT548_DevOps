data "aws_partition" "current" {}

locals {
  create = var.create 

  is_t_instance_type = replace(var.instance_type, "/^t(2|3|3a|4g){1}\\..*$/", "1") == "1" ? true : false

  ami = try(coalesce(var.ami, try(nonsensitive(data.aws_ssm_parameter.this[0].value), null)), null)
}

data "aws_ssm_parameter" "this" {
  count = local.create && var.ami == null ? 1 : 0

  name = var.ami_ssm_parameter
}

################################################################################
# EC2 Instance
################################################################################

resource "aws_instance" "this" {
  count = local.create 
  ami                  = local.ami
  instance_type        = var.instance_type
  
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  key_name             = var.key_name
  monitoring           = var.monitoring
  associate_public_ip_address = var.associate_public_ip_address
  private_ip                  = var.private_ip
  source_dest_check                    = length(var.network_interface) > 0 ? null : var.source_dest_check
  
  dynamic "network_interface" {
    for_each = var.network_interface

    content {
      device_index          = network_interface.value.device_index
      network_interface_id  = lookup(network_interface.value, "network_interface_id", null)
      delete_on_termination = try(network_interface.value.delete_on_termination, false)
    }
  }

  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  tags        = merge({ "Name" = var.name }, var.instance_tags, var.tags)

}