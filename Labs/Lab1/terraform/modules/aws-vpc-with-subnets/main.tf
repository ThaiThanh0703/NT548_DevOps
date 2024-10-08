locals {
  create_vpc = var.create_vpc
}

################################################################################
# VPC
################################################################################

resource "aws_vpc" "this" {
  count = local.create_vpc ? 1 : 0
  cidr_block          = var.cidr
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

