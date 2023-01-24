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

  user_data = templatefile("${path.module}/user_data.tftpl", {
    hostname        = random_pet.server.id
    nginx-repo-crt  = base64encode(var.nginx_repo_crt)
    nginx-repo-key  = base64encode(var.nginx_repo_key)
    nginx-agent-crt = var.nginx_agent_crt != null ? base64encode(var.nginx_agent_crt) : ""
    nginx-agent-key = var.nginx_agent_key != null ? base64encode(var.nginx_agent_key) : ""
    nms_host        = var.nms_host != null ? var.nms_host : ""
  })

  tags = {
    Name  = format("%s-nginx-%s", local.owner_name_safe, random_pet.server.id)
    Owner = var.owner_email
  }
}
