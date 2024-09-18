# Create aws-ec2 instance for Docker with a Security Group  
#

resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.ec2-type
  key_name               = var.ec2-key
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  user_data_base64 = base64encode(templatefile("userdata.sh", { git-repo = var.git-repo,
  db-pass = data.aws_ssm_parameter.db-user-pass.value, db-root-pass = data.aws_ssm_parameter.db-root-pass.value }))

  # Non-secure method for passing database secrets. Comment out the previous 2 lines before use.
  #user_data_base64       = base64encode(templatefile("userdata.sh", { git-repo = var.git-repo, 
  #db-pass = var.db-user-pass, db-root-pass = var.db-root-pass }))

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
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "webserver-sg_allow_all_traffic" {
  security_group_id = aws_security_group.webserver-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
