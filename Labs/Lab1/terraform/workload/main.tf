################################################################################
# VPC
################################################################################
module "vpc" {
  source = "../modules/aws-vpc-with-subnets"

  create_vpc                        = true
  name                              = "main_vpc"
  cidr                              = "10.0.0.0/16"
  enable_network_address_usage_metrics = true

  azs                               = ["us-east-1a", "us-east-1b"]
  public_subnets                    = ["10.0.0.0/24", "10.0.1.0/24"]
  map_public_ip_on_launch           = true
  public_subnet_suffix              = "public"

  private_subnets                   = ["10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_suffix             = "private"

  create_igw                        = true

  tags = {
    Environment = "Development"
  }
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
  azs                             = ["us-east-1a", "us-east-1b"]
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


