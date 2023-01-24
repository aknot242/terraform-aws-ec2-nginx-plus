# Terraform AWS EC2 NGINX Plus

Create an NGINX Plus AWS EC2 Instance in the designated environment.

## Terraform Variables

| Variable  | Description  |
|---|---|
| associate_public_ip_address | Boolean value as to whether to associate a public IP address with the instance |
| aws_access_key | AWS access key |
| aws_secret_key | AWS secret key |
| instance_type  |  EC2 instance type |
| key_name | EC2 Key Pair name  |
| nginx_repo_certificate | Base64 encoded NGINX Repository Certificate |
| nginx_repo_key | Base64 encoded NGINX Repository Key |
| owner_name  | Name of user deploying Terraform - for AWS resource tagging  |
| owner_email | Email of user deploying Terraform - for AWS resource tagging |
| subnet_id | AWS VPC Subnet ID |
| vcp_security_group_ids | List of AWS Security Groups for the EC2 instance |

## Usage

```hcl
module "nginx-plus" {
  source                 = "codygreen/ec2-nginx-plus"
  aws_access_key         = aws_access_key
  aws_secret_key         = aws_secret_key
  nginx_repo_certificate = nginx_repo_cert
  nginx_repo_key         = nginx_repo_key
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
