#!/bin/bash
yum update -y
yum install git -y
# Install docker and docker-compose standalone.
yum install docker -y
systemctl enable docker.service
systemctl start docker.service
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
chmod -v +x /usr/local/bin/docker-compose
# Set env vars to pass secrets. One time use.
export DB_PASS=${db-pass} DB_ROOT_PASS=${db-root-pass}
cd /home/ec2-user
git clone ${git-repo}
cd /home/ec2-user/203-dockerization-bookstore-api-on-python-flask-mysql
rm -rf tf-files tf-ssm-files
# Replace mysql user password in application code.
sed -i 's|db_pass_to_replace|'$DB_PASS'|' bookstore-api.py 
docker-compose up -d
