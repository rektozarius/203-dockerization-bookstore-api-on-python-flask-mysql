terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

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

variable "git-repo" {
  default = 
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  user_data_base64 = base64encode(templatefile("userdata.sh", ))

  tags = {
    Name = "Web Server of Bookstore"
  }
}

resource "aws_security_group" "webserver-sg" {
  name        = "webserver-sg"
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    Name = "webserver-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "webserver-sg_allow_http" {
  security_group_id = aws_security_group.webserver-sg.id
  cidr_ipv4         = data.aws_vpc.selected.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "webserver-sg_allow_ssh" {
  security_group_id = aws_security_group.webserver-sg.id
  cidr_ipv4         = data.aws_vpc.selected.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "webserver-sg_allow_all_traffic" {
  security_group_id = aws_security_group.webserver-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
