variable "aws_region" {
  type    = string
  default = "us-east-1"  # N. Virginia
}

variable "ami_id" {
  type    = string
  default = "ami-0e86e20dae9224db8" # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
}

variable "instance_type" {
  type    = string
  default = "t2.nano"
}

variable "key_pair" {
  type = string
}
