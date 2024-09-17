#!/bin/bash
yum update -y
yum install docker -y
yum install git -y
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
chmod -v +x /usr/local/bin/docker-compose
systemctl enable docker.service
systemctl start docker.service
usermod -a -G docker ec2-user
cd /home/ec2-user
git clone ${git-repo}

