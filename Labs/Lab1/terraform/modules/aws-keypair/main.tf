################################################################################
# SSH Keypair
################################################################################
resource "tls_private_key" "tls" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.tls.public_key_openssh
}

resource "local_file" "local_key_pair" {
  content = tls_private_key.tls.private_key_pem
  filename = "${var.key_name}.pem"
  file_permission = "0400"
}

