output "phonebook-app-url" {
  value = aws_instance.webserver.public_ip
  description = "Wait a few minutes"
}