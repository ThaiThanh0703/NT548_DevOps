################################################################################
# SSH Keypair
################################################################################
variable "key_name" {
  description = "Name of the keypair"
  type = string
  default = ""
}
variable "rsa_bits" {
  description = "(Number) When algorithm is RSA, the size of the generated RSA key, in bits (default: 2048)."
  type = number
  default = 2048
}