output "instance_name" {
  value = random_pet.server.id
}

output "instance_private_ip_addr" {
  value = aws_instance.nginx.private_ip
}

output "instance_public_ip_addr" {
  value = aws_instance.nginx.public_ip
}
