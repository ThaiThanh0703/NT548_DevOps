
################################################################################
# General Variables
################################################################################
access_key = "enter your access_key"

secret_key = "enter your secret_key"

tags = {
  "tag" = "lab1-gr23"
}

name = "nt548"

cidr = "10.0.0.0/16"

azs = ["us-east-1a", "us-east-1b"]

region = "us-east-1"

################################################################################
# VPC
################################################################################
create_vpc = true

enable_network_address_usage_metrics = true

vpc_tags = {
  "Name" = "group23-vpc",
}


################################################################################
# Public Subnet
################################################################################
public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

map_public_ip_on_launch = true

public_subnet_suffix = "pb_subnet"

public_subnet_tags = {
  "Name" = "group23-pbsn",
}

################################################################################
# Private Subnet
################################################################################
private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]

private_subnet_suffix = "pr_subnet"

private_subnet_tags = {
  "Name" = "group23-prsn"
}
################################################################################
# Internet Gateway
################################################################################
create_igw = true

igw_tags = {
  "Name" = "group23-igw"
}

################################################################################
# NAT Gateway
################################################################################
single_nat_gateway = true

reuse_nat_ips = false

nat_eip_tags = {
  "Name" = "group23-natip"
}

nat_gateway_tags = {
  "Name" = "group23-natgw"
}
################################################################################
# Route Table
################################################################################
create_multiple_public_route_tables = true

nat_gateway_destination_cidr_block = "0.0.0.0/0"

public_route_table_tags = {
  "Name" = "group23-pbrt"
}

private_route_table_tags = {
  "Name" = "group23-prrt"
}

################################################################################
# Keypair
################################################################################
key_name = "group23"

rsa_bits = 4096
################################################################################
# EC2
################################################################################
create_ec2 = true

instance_type = "t2.micro"

ami = "ami-0fff1b9a61dec8a5f"

associate_public_ip_address = true
################################################################################
# Security Group
################################################################################
create_sg = true

description_pb_sg = "Public Security Group for Public EC2 Instances"

description_pr_sg = "Private Security Group for Privat EC2 Instances"

ingress_rules = ["ssh-tcp"]

egress_rules = ["all-all"]

specific_ip = "1.53.55.230/32"


