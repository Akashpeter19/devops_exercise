provider "aws" {
  region = "ap-south-1"
}

############################
# Get Latest Amazon Linux 2
############################
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

############################
# Get Default VPC
############################
data "aws_vpc" "default" {
  default = true
}

############################
# Security Group
############################
resource "aws_security_group" "web_sg" {
  name   = "terraform-web-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

############################
# EC2 Instance
############################
resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  key_name                    = "jenkins"
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras enable nginx1",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "echo '<h1>Remote Exec Success 🚀</h1>' | sudo tee /usr/share/nginx/html/index.html"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("jenkins.pem")
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> ip.txt"
  }

  tags = {
    Name = "Terraform-Web"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "website_url" {
  value = "http://${aws_instance.web.public_ip}"
}
