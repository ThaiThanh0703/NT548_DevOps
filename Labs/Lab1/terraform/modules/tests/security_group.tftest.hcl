run "validate" {
  command = apply

  module {
    source = "../aws-security-group"
  }

  assert {
    condition     = module.security_group.security_group_id != ""
    error_message = "Fail to create public security group"
  }
}
