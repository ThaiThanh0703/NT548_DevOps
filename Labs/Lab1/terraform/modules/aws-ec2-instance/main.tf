data "aws_partition" "current" {}

locals {
  create = var.create 

  is_t_instance_type = replace(var.instance_type, "/^t(2|3|3a|4g){1}\\..*$/", "1") == "1" ? true : false

  #ami = try(coalesce(var.ami, try(nonsensitive(data.aws_ssm_parameter.this[0].value), null)), null)
}

#data "aws_ssm_parameter" "this" {
#  count = local.create && var.ami == null ? 1 : 0

#  name = var.ami_ssm_parameter
#}

################################################################################
# EC2 Instance
################################################################################

resource "aws_instance" "this" {
  count = local.create ? 1:0
  ami                  = var.ami
  instance_type        = var.instance_type
  
  availability_zone      = var.availability_zone
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  key_name             = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  

  tags        = merge({ "Name" = var.name }, var.instance_tags, var.tags)

}