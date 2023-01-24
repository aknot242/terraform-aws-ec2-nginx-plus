data "template_file" "nginx_repo_crt" {
  template = file("${path.module}/nginx-repo.crt")
}
data "template_file" "nginx_repo_key" {
  template = file("${path.module}/nginx-repo.key")
}
data "template_file" "nginx_agent_crt" {
  template = file("${path.module}/agent.crt")
}
data "template_file" "nginx_agent_key" {
  template = file("${path.module}/agent.key")
}
module "nginx-plus" {
  source                 = "../../"
  aws_access_key         = var.aws_access_key
  aws_secret_key         = var.aws_secret_key
  nginx_repo_crt         = data.template_file.nginx_repo_crt.rendered
  nginx_repo_key         = data.template_file.nginx_repo_key.rendered
  nginx_agent_crt        = data.template_file.nginx_agent_crt.rendered
  nginx_agent_key        = data.template_file.nginx_agent_key.rendered
  nms_host               = var.nms_host
  key_name               = var.key_name
  owner_name             = var.owner_name
  owner_email            = var.owner_email
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
}
