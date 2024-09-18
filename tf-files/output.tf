output "phonebook-app-url" {
  value = aws_instance.webserver.public_dns
  description = "Wait a few minutes"
}