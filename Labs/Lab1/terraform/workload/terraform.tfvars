
################################################################################
# General Variables
################################################################################
access_key = "enter your access_key"

secret_key = "enter your secret_key"

tags = "lab1"

name = "nt548"

cidr = "10.0.0.0/16"

azs = ["us-east-1a", "us-east-1b"]

################################################################################
# VPC
################################################################################
create_vpc = true

enable_network_address_usage_metrics = true

vpc_tags = {
  "name" = "group23-vpc",
}


################################################################################
# Public Subnet
################################################################################
public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

map_public_ip_on_launch = true

public_subnet_suffix = "pb_subnet"

public_subnet_tags = {
  "name" = "group23-pbsn",
}

################################################################################
# Private Subnet
################################################################################
private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]

private_subnet_suffix = "pr_subnet"

private_subnet_tags = {
  "name" = "group23-prsn"
}
################################################################################
# Internet Gateway
################################################################################
create_igw = true

igw_tags = {
  "name" = "group23-igw"
}

################################################################################
# NAT Gateway
################################################################################
single_nat_gateway = true

reuse_nat_ips = false

nat_eip_tags = {
  "name" = "group23-natip"
}

nat_gateway_tags = {
  "name" = "group23-natgw"
}
################################################################################
# Route Table
################################################################################
create_multiple_public_route_tables = true

nat_gateway_destination_cidr_block = "0.0.0.0/0"

public_route_table_tags = {
  "name" = "group23-pbrt"
}

private_route_table_tags = {
  "name" = "group23-prrt"
}
################################################################################
# EC2
################################################################################

################################################################################
# Security Group
################################################################################