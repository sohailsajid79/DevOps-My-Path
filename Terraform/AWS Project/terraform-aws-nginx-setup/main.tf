module "ec2" {
  source        = "./modules/ec2"
  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = aws_key_pair.generate_key.key_name
 }