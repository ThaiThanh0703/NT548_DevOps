################################################################################
# VPC
################################################################################
module "vpc" {
  source = "../modules/aws-vpc-with-subnets"

  create_vpc                           = var.create_vpc
  create_igw                           = var.create_igw
  cidr                                 = var.cidr
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  azs                                  = var.azs

  public_subnets          = var.public_subnets
  map_public_ip_on_launch = var.map_public_ip_on_launch
  public_subnet_suffix    = var.public_subnet_suffix

  private_subnets       = var.private_subnets
  private_subnet_suffix = var.private_subnet_suffix

  tags                = var.tags
  private_subnet_tags = var.private_subnet_tags
  public_subnet_tags  = var.public_subnet_tags
  igw_tags            = var.igw_tags
  vpc_tags            = var.vpc_tags
}


################################################################################
# Route Table
################################################################################

module "route_table" {
  source = "../modules/aws-route-table"

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  public_subnets        = var.private_subnets
  public_subnet_suffix  = var.public_subnet_suffix
  private_subnet_ids    = module.vpc.private_subnet_ids
  private_subnets       = var.private_subnets
  private_subnet_suffix = var.private_subnet_suffix

  create_multiple_public_route_tables = var.create_multiple_public_route_tables
  single_nat_gateway                  = var.single_nat_gateway
  nat_gateway_ids                     = module.nat_gateway.natgw_ids
  nat_gateway_destination_cidr_block  = var.nat_gateway_destination_cidr_block
  internet_gateway_id                 = module.vpc.igw_id
  azs                                 = var.azs

  name                     = var.name
  tags                     = var.tags
  public_route_table_tags  = var.public_route_table_tags
  private_route_table_tags = var.private_route_table_tags

}

################################################################################
# NAT Gateway
################################################################################
module "nat_gateway" {
  source = "../modules/aws-nat-gateway"

  reuse_nat_ips      = var.reuse_nat_ips
  single_nat_gateway = var.single_nat_gateway

  public_subnet_ids = module.vpc.public_subnet_ids
  azs               = var.azs

  tags             = var.tags
  nat_eip_tags     = var.nat_eip_tags
  nat_gateway_tags = var.nat_gateway_tags
}

################################################################################
# Keypair
################################################################################
module "ssh_keypair" {
  source = "../modules/aws-keypair"

  key_name = var.key_name

  rsa_bits = var.rsa_bits
}

################################################################################
# Public EC2 Instance
################################################################################

module "public_ec2_instance" {
  source = "../modules/aws-ec2-instance"

  for_each = zipmap(var.azs, module.vpc.public_subnet_ids)

  availability_zone           = each.key
  subnet_id                   = each.value
  create                      = var.create_ec2
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [module.public_ec2_security_group.security_group_id]
  key_name                    = module.ssh_keypair.key_name
  associate_public_ip_address = var.associate_public_ip_address
  instance_tags               = { "Name" = "ec2-${each.key}" }
  tags                        = var.tags

}


################################################################################
# Private EC2 Instance
################################################################################

module "private_ec2_instance" {
  source = "../modules/aws-ec2-instance"

  for_each = zipmap(var.azs, module.vpc.private_subnet_ids)

  availability_zone           = each.key
  subnet_id                   = each.value
  create                      = var.create_ec2
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [module.private_ec2_security_group.security_group_id]
  key_name                    = module.ssh_keypair.key_name
  associate_public_ip_address = false
  instance_tags               = { "Name" = "ec2-${each.key}" }
  tags                        = var.tags
}

################################################################################
# Public EC2 Security Group
################################################################################

module "public_ec2_security_group" {
  source              = "../modules/aws-security-group"
  description         = var.description_pb_sg
  name                = var.name
  prefix              = var.prefix_pb_sg
  vpc_id              = module.vpc.vpc_id
  tags                = var.tags
  ingress_rules       = var.ingress_rules
  ingress_cidr_blocks = [var.specific_ip]
  egress_rules        = var.egress_rules

}


################################################################################
# Private EC2 Security Group
################################################################################

module "private_ec2_security_group" {
  source = "../modules/aws-security-group"

  description         = var.description_pr_sg
  name                = var.name
  prefix              = var.prefix_pr_sg
  vpc_id              = module.vpc.vpc_id
  tags                = var.tags
  security_group_id   = module.public_ec2_security_group.security_group_id
  ingress_rules       = var.ingress_rules
  ingress_cidr_blocks = var.public_subnets
  egress_rules        = var.egress_rules

}


