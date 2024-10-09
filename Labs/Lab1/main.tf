terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

# Configure the AWS Provider
provider "aws" {
    region     = "us-east-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

# Use the VPC Module
module "vpc" {
   source = "./terraform/modules/aws-vpc-with-subnets"  

  create_vpc                     = true
  name                           = "main_vpc"
  cidr                           = "10.0.0.0/16"
  azs                            = ["us-east-1a", "us-east-1b"]
  enable_network_address_usage_metrics = true

  public_subnets                 = ["10.0.0.0/24", "10.0.1.0/24"]
  map_public_ip_on_launch        = true
  public_subnet_suffix           = "public"

  private_subnets                = ["10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_suffix          = "private"

  create_igw                     = true

  tags = {
    Environment = "Development"
  }
}
