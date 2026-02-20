module "web_server" {
  source        = "./modules/ec2"
  ami_id        = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type = "t3.micro"
}

output "ec2_id" {
  value = module.web_server.instance_id
}

