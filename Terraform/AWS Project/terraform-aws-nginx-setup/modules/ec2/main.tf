resource "aws_key_pair" "key_pair" {
  key_name   = "aws-key"
  public_key = file("./aws-key.pem")
}

resource "aws_security_group" "sg" {
  name = "nginx-sg"

  ingress {
    description = "allow http traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}

resource "aws_instance" "nginx" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair

  security_groups = [aws_security_group.sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "ec2-nginx"
  }
}