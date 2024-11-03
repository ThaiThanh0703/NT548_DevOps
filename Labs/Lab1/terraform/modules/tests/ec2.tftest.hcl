run "validate" {
  command = apply

  module {
    source = "../aws-ec2-instance"
  }

  assert {
    condition     = module.ec2.id != ""
    error_message = "Fail to create EC2 instance"
  }
}

