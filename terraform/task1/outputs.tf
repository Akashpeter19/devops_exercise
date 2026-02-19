output "mumbai_instance_public_ip" {
  description = "Public IP of Mumbai EC2"
  value       = aws_instance.mumbai_ec2.public_ip
}

output "useast_instance_public_ip" {
  description = "Public IP of US East EC2"
  value       = aws_instance.useast_ec2.public_ip
}
