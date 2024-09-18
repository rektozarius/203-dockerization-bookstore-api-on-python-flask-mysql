# Public ip address of the ec2 instance. Wait for a few minutes to initialize.
#

output "phonebook-app-url" {
  value = aws_instance.webserver.public_ip
}