# Retrieve default vpc, latest Amazon Linux 2 AMI and db passwords
#

data "aws_vpc" "selected" {
  default = true
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

data "aws_ssm_parameter" "db-user-pass" {
  name = "/203/database/password/user"
}

data "aws_ssm_parameter" "db-root-pass" {
  name = "/203/database/password/root"
}