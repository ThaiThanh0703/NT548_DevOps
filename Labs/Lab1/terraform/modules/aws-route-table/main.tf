################################################################################
# Public Route Table
################################################################################
locals {
  len_public_subnets      = length(var.public_subnets)
  len_private_subnets     = length(var.private_subnets)
  num_public_route_tables  = var.create_multiple_public_route_tables ? local.len_public_subnets : 1
}

# Create route tables for public subnets
resource "aws_route_table" "public" {
  count = local.num_public_route_tables

  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = var.create_multiple_public_route_tables ? format(
        "${var.name}-${var.public_subnet_suffix}-%s",
        element(var.azs, count.index),
      ) : "${var.name}-${var.public_subnet_suffix}"
    },
    var.tags,
    var.public_route_table_tags,
  )
}

# Associate public subnets with public route tables
resource "aws_route_table_association" "public" {
  count = local.len_public_subnets

  subnet_id      = element(var.public_subnet_ids, count.index)
  route_table_id = element(aws_route_table.public[*].id, var.create_multiple_public_route_tables ? count.index : 0)
}

# Create route for Internet Gateway in public route tables
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
locals {
  nat_gateway_count = var.single_nat_gateway ? 1 : length(var.nat_gateway_ids) # Đảm bảo bạn đã định nghĩa var.nat_gateway_ids
}

# Create route tables for private subnets
resource "aws_route_table" "private" {
  count = local.nat_gateway_count  # Sử dụng count ở đây

  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = var.single_nat_gateway ? "${var.name}-${var.private_subnet_suffix}" : format(
        "${var.name}-${var.private_subnet_suffix}-%s",
        element(var.azs, count.index),
      )
    },
    var.tags,
    var.private_route_table_tags,
  )
}

# Associate private subnets with private route tables
resource "aws_route_table_association" "private" {
  count = local.len_private_subnets

  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = element(
    aws_route_table.private[*].id,
    var.single_nat_gateway ? 0 : count.index,
  )
}

# Create route for NAT Gateway in private route tables
resource "aws_route" "private_nat_gateway" {
  count = local.nat_gateway_count

  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = var.nat_gateway_destination_cidr_block
  nat_gateway_id         = element(var.nat_gateway_ids, count.index)

  timeouts {
    create = "5m"
  }
}
