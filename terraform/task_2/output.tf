output "us_public_ip" {
  value = aws_instance.us_instance.public_ip
}

output "mumbai_public_ip" {
  value = aws_instance.mumbai_instance.public_ip
}
