################################################################################
# Get ID of created Security Group
################################################################################
locals {
  create = var.create 

  this_sg_id = var.create_sg ? aws_security_group.this.id : var.security_group_id
}
################################################################################
# Security group with name
################################################################################
resource "aws_security_group" "this" {

  name                   = "${var.prefix}_${var.name}_sg"
  description            = var.description
  vpc_id                 = var.vpc_id
  tags = merge(
    {
      "Name" = format("%s - %s ",var.prefix, var.name)
    },
    var.tags,
  )

  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }
}

################################################################################
# Ingress - List of rules 
################################################################################
resource "aws_security_group_rule" "ingress_rules" {
  count = local.create ? length(var.ingress_rules) : 0

  security_group_id = local.this_sg_id
  type              = "ingress"

  cidr_blocks      = var.ingress_cidr_blocks
  description      = var.rules[var.ingress_rules[count.index]][3]

  from_port = var.rules[var.ingress_rules[count.index]][0]
  to_port   = var.rules[var.ingress_rules[count.index]][1]
  protocol  = var.rules[var.ingress_rules[count.index]][2]
}

################################################################################
# Egress - List of rules
################################################################################
resource "aws_security_group_rule" "egress_rules" {
  count = local.create ? length(var.egress_rules) : 0

  security_group_id = local.this_sg_id
  type              = "egress"

  cidr_blocks      = var.egress_cidr_blocks
  description      = var.rules[var.egress_rules[count.index]][3]

  from_port = var.rules[var.egress_rules[count.index]][0]
  to_port   = var.rules[var.egress_rules[count.index]][1]
  protocol  = var.rules[var.egress_rules[count.index]][2]
}