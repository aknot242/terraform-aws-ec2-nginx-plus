resource "random_pet" "server" {
  length = 2
}
resource "aws_instance" "nginx" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name

  user_data = templatefile("${path.module}/user_data.tpl", {
    hostname       = random_pet.server.id
    nginx-repo-crt = base64encode(var.nginx_repo_certificate)
    nginx-repo-key = base64encode(var.nginx_repo_key)
  })

  tags = {
    Name  = format("%s-nginx-%s", local.owner_name_safe, random_pet.server.id)
    Owner = var.owner_email
  }
}
