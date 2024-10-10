################################################################################
# Locals
################################################################################
locals {
  len_public_subnets      = length(var.public_subnet_ids)
  len_private_subnets     = length(var.private_subnet_ids)
  num_public_route_tables = var.create_multiple_public_route_tables ? local.len_public_subnets : 1
  nat_gateway_count       = var.single_nat_gateway ? 1 : length(var.nat_gateway_ids)
}

################################################################################
# Public Route Table
################################################################################

resource "aws_route_table" "public" {
  count  = local.num_public_route_tables
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = var.create_multiple_public_route_tables ? format(
        "${var.name}-${var.public_subnet_suffix}-%s",
        element(var.azs, count.index)
      ) : "${var.name}-${var.public_subnet_suffix}"
    },
    var.tags,
    var.public_route_table_tags,
  )
}

resource "aws_route_table_association" "public" {
  count        = local.len_public_subnets
  subnet_id    = element(var.public_subnet_ids, count.index)
  route_table_id = element(
    aws_route_table.public[*].id,
    var.create_multiple_public_route_tables ? count.index : 0
  )
}

resource "aws_route" "public_internet_gateway" {
  count = local.num_public_route_tables

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_id

  timeouts {
    create = "5m"
  }
}

################################################################################
# Private Route Table
################################################################################

resource "aws_route_table" "private" {
  count  = local.nat_gateway_count
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = var.single_nat_gateway ? "${var.name}-${var.private_subnet_suffix}" : format(
        "${var.name}-${var.private_subnet_suffix}-%s",
        element(var.azs, count.index)
      )
    },
    var.tags,
    var.private_route_table_tags,
  )
}

resource "aws_route_table_association" "private" {
  count        = local.len_private_subnets
  subnet_id    = element(var.private_subnet_ids, count.index)
  route_table_id = element(
    aws_route_table.private[*].id,
    var.single_nat_gateway ? 0 : count.index
  )
}

resource "aws_route" "private_nat_gateway" {
  count = local.nat_gateway_count

  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = var.nat_gateway_destination_cidr_block
  nat_gateway_id         = element(var.nat_gateway_ids, count.index)

  timeouts {
    create = "5m"
  }
}
