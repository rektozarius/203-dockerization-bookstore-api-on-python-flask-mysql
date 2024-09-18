#!/bin/bash
yum update -y
yum install git -y
yum install docker -y
systemctl enable docker.service
systemctl start docker.service
usermod -a -G docker ec2-user
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
chmod -v +x /usr/local/bin/docker-compose
echo DB_PASS=${db-pass} >> /etc/profile
echo DB_ROOT_PASS=${db-root-pass} >> /etc/profile
cd /home/ec2-user
git clone ${git-repo}
cd /home/ec2-user/203-dockerization-bookstore-api-on-python-flask-mysql
rm -rf tf-files
sed -i "s/db_pass_to_replace/${DB_PASS}/g" bookstore-api.py 
docker-compose up -d
