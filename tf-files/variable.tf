variable "git-repo" {
  default = "https://github.com/rektozarius/203-dockerization-bookstore-api-on-python-flask-mysql.git"
}

variable "ec2-type" {
  default = "t2.micro"
}

# Using ssm parameter store is recommended instead. Don't forget to change relevant commented out lines in main.tf
variable "db-user-pass" {
  default = ""
}

variable "db-root-pass" {
  default = ""
}