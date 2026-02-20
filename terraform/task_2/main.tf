########################################
# AMI FOR US-EAST-1
########################################

data "aws_ami" "amazon_linux_us" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

########################################
# AMI FOR MUMBAI (ap-south-1)
########################################

data "aws_ami" "amazon_linux_mumbai" {
  provider    = aws.mumbai
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

########################################
# SECURITY GROUP - US REGION
########################################

resource "aws_security_group" "allow_http_us" {
  name        = "allow_http_ssh_us"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}

########################################
# SECURITY GROUP - MUMBAI REGION
########################################

resource "aws_security_group" "allow_http_mumbai" {
  provider    = aws.mumbai
  name        = "allow_http_ssh_mumbai"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}

########################################
# EC2 - US REGION
########################################

resource "aws_instance" "us_instance" {
  ami           = data.aws_ami.amazon_linux_us.id
  instance_type = "t3.micro"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_http_us.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable nginx1
              yum install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "Task2-US-Instance"
  }
}

########################################
# EC2 - MUMBAI REGION
########################################

resource "aws_instance" "mumbai_instance" {
  provider      = aws.mumbai
  ami           = data.aws_ami.amazon_linux_mumbai.id
  instance_type = "t3.micro"

  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_http_mumbai.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable nginx1
              yum install -y nginx
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "Task2-Mumbai-Instance"
  }
}
