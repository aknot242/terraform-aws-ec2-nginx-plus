# Terraform AWS EC2 NGINX Plus

Create an NGINX Plus AWS EC2 Instance in the designated environment.

> Note: an NGINX Plus repository certificate and key are required for this deployment

## Terraform Variables

| Variable  | Description  | Default Value |
|---|---|---|
| associate_public_ip_address | Boolean value as to whether to associate a public IP address with the instance | |
| aws_access_key | AWS access key | |
| aws_secret_key | AWS secret key | |
| instance_type  |  EC2 instance type | |
| key_name | EC2 Key Pair name  | |
| nginx_agent_crt | NGINX Agent Certificate | null |
| nginx_agent_key | NGINX Agent Key | null |
| nginx_repo_crt | NGINX Repository Certificate | |
| nginx_repo_key | NGINX Repository Key | |
| nms_host | NGINX Management Suite FQDN | null |
| owner_name  | Name of user deploying Terraform - for AWS resource tagging  | |
| owner_email | Email of user deploying Terraform - for AWS resource tagging | |
| subnet_id | AWS VPC Subnet ID | |
| vpc_security_group_ids | List of AWS Security Groups for the EC2 instance | |

## Usage

NGINX Plus:

```hcl
module "nginx-plus" {
  source                 = "f5devcentral/ec2-nginx-plus"
  aws_access_key         = aws_access_key
  aws_secret_key         = aws_secret_key
  nginx_repo_crt         = nginx_repo_crt
  nginx_repo_key         = nginx_repo_key
  key_name               = mykey
  owner_name             = "John Doe"
  owner_email            = j.doe@nginx.com
  subnet_id              = subnet_1245
  vpc_security_group_ids = ["sg_2485023940284"]
}
```

NGINX Plus with Agent connected to NMS:

```hcl
module "nginx-plus" {
  source                 = "f5devcentral/ec2-nginx-plus"
  aws_access_key         = aws_access_key
  aws_secret_key         = aws_secret_key
  nginx_agent_crt        = nginx_agent_crt
  nginx_agent_key        = nginx_agent_key
  nginx_repo_crt         = nginx_repo_crt
  nginx_repo_key         = nginx_repo_key
  nms_host               = nms_host.example.com
  key_name               = mykey
  owner_name             = "John Doe"
  owner_email            = j.doe@nginx.com
  subnet_id              = subnet_1245
  vpc_security_group_ids = ["sg_2485023940284"]
}
```

## Terraform Output

| Variable  | Description  |
|---|---|
| instance_name | Instance short name |
| instance_private_ip_addr | Instance Private IP Address |
| instance_public_ip_addr | Instance Public IP Address |
