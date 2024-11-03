run "validate" {
  command = apply

  module {
    source = "../aws-vpc-with-subnets"
  }

  assert {
    condition     = module.vpc.aws_vpc_id != ""
    error_message = "Fail to create vpc"
  }

  assert {
    condition     = module.vpc.default_security_group_id != ""
    error_message = "Fail to create default security group"
  }
}

