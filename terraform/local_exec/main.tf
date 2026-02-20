provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.micro"

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> instance_ip.txt"
  }

  tags = {
    Name = "LocalExecDemo"
  }
}

