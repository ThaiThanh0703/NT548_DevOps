################################################################################
# VPC
################################################################################
module "vpc" {
  source = "../modules/aws-vpc-with-subnets"

  create_vpc = var.create_vpc
  cidr                             = var.cidr
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  azs                           = var.azs
  
  public_subnets                    = var.public_subnets
  map_public_ip_on_launch           = var.map_public_ip_on_launch
  public_subnet_suffix              = var.public_subnet_suffix

  private_subnets                   = var.private_subnets
  private_subnet_suffix             = var.private_subnet_suffix

  create_igw                        = var.create_igw

  tags = var.tags
  private_subnet_tags = var.private_subnet_tags
  public_subnet_tags = var.public_subnet_tags
  igw_tags = var.igw_tags
  vpc_tags = var.vpc_tags
}


################################################################################
# Route Table
################################################################################

module "route_table" {
  source                          = "../modules/aws-route-table"

  vpc_id                          = module.vpc.vpc_id
  public_subnet_ids               = module.vpc.public_subnet_ids
  private_subnet_ids              = module.vpc.private_subnet_ids
  create_multiple_public_route_tables = true
  single_nat_gateway              = false
  nat_gateway_ids                 = module.nat_gateway.natgw_ids
  internet_gateway_id             = module.vpc.igw_id  
  azs                             = var.azs
  name                            = "main_vpc"
  public_subnet_suffix            = "public"
  private_subnet_suffix           = "private"
  tags = {
    Environment = "Development"
  }
}

################################################################################
# NAT Gateway
################################################################################
module "nat_gateway" {
  source              = "../modules/aws-nat-gateway"
  public_subnet_ids   = module.vpc.public_subnet_ids
  azs                 = ["us-east-1a", "us-east-1b"]  
  single_nat_gateway  = true
}

################################################################################
# Public EC2 Instance
################################################################################

module "public_ec2_instance" {
  source = "../modules/aws-ec2-instance"
}


################################################################################
# Private EC2 Instance
################################################################################

module "private_ec2_instance" {
  source = "../modules/aws-ec2-instance"
}

################################################################################
# Public EC2 Security Group
################################################################################

module "public_ec2_security_group" {
  source = "../modules/aws-security-group"
}


################################################################################
# Private EC2 Security Group
################################################################################

module "private_ec2_security_group" {
  source = "../modules/aws-security-group"
}


