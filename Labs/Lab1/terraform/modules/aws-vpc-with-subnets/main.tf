locals {
  create_vpc = var.create_vpc
}

################################################################################
# VPC
################################################################################

resource "aws_vpc" "this" {
  count = local.create_vpc ? 1 : 0
  cidr_block = var.cidr
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

################################################################################
# Public Subnets
################################################################################

locals {
  create_public_subnets = local.create_vpc 
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  availability_zone = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  cidr_block = element(concat(var.public_subnets, [""]), count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  vpc_id = aws_vpc.this[0].id  

  tags = merge(
    {
      Name = try(
        var.public_subnet_names[count.index],
        format("${var.name}-${var.public_subnet_suffix}-%s", element(var.azs, count.index))
      )
    },
    var.tags,
    var.public_subnet_tags,
    lookup(var.public_subnet_tags_per_az, element(var.azs, count.index), {})
  )
}

################################################################################
# Private Subnets
################################################################################

locals {
  create_private_subnets = local.create_vpc
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  availability_zone = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  cidr_block = element(concat(var.private_subnets, [""]), count.index)
  vpc_id = aws_vpc.this[0].id 

  tags = merge(
    {
      Name = try(
        var.private_subnet_names[count.index],
        format("${var.name}-${var.private_subnet_suffix}-%s", element(var.azs, count.index))
      )
    },
    var.tags,
    var.private_subnet_tags,
    lookup(var.private_subnet_tags_per_az, element(var.azs, count.index), {})
  )
}

################################################################################
# Default Security Group
################################################################################

resource "aws_security_group" "default" {
  count = local.create_vpc ? 1 : 0  
  vpc_id = aws_vpc.this[0].id  

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-${aws_vpc.this[0].id}-default-sg" 
  }
}

################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "this" {
  count = local.create_public_subnets && var.create_igw ? 1 : 0

  vpc_id = aws_vpc.this[0].id 

  tags = merge(
  { "Name" = var.name },
  var.tags,
  var.igw_tags,
  )
}
