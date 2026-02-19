# Get latest Amazon Linux 2 AMI (Mumbai)
data "aws_ami" "amazon_linux_mumbai" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Get latest Amazon Linux 2 AMI (US East)
data "aws_ami" "amazon_linux_useast" {
  provider    = aws.useast
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 in Mumbai (ap-south-1)
resource "aws_instance" "mumbai_ec2" {
  ami           = data.aws_ami.amazon_linux_mumbai.id
  instance_type = "t3.micro"

  tags = {
    Name = "Mumbai-EC2"
  }
}

# EC2 in US East (us-east-1)
resource "aws_instance" "useast_ec2" {
  provider      = aws.useast
  ami           = data.aws_ami.amazon_linux_useast.id
  instance_type = "t3.micro"

  tags = {
    Name = "USEast-EC2"
  }
}
