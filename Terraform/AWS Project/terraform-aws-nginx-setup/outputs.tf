output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "private_key" {
  value     = tls_private_key.pem.private_key_pem
  sensitive = true
}