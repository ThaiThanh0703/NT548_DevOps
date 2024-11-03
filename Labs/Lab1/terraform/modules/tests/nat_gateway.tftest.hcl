run "validate" {
  command = apply

  module {
    source = "../aws-nat-gateway"
  }

  assert {
    condition     = module.nat_gateway.natgw_ids != ""
    error_message = "Fail to create nat gateway"
  }
}

