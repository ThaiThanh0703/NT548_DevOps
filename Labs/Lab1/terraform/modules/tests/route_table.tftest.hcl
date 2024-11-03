run "validate" {
  command = apply

  module {
    source = "../aws-route-table"
  }

  assert {
    condition     = module.route_table.public_route_table_ids != ""
    error_message = "Fail to create public route table"
  }

  assert {
    condition     = module.route_table.private_route_table_ids != ""
    error_message = "Fail to create private route table"
  }

  assert {
    condition     = module.route_table.public_route_assocication_ids != ""
    error_message = "Fail to associate with public route table"
  }

  assert {
    condition     = module.route_table.privat_route_assocication_ids != ""
    error_message = "Fail to associate with public route table"
  }

}

