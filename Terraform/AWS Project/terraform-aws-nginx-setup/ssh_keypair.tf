resource "tls_private_key" "pem" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generate_key" {
  key_name   = var.key_pair
  public_key = tls_private_key.pem.public_key_openssh
}