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

# Enter your preferred passwords as String values
variable "db-user-pass" {
  default = ""
}

variable "db-root-pass" {
  default = ""
}

resource "aws_ssm_parameter" "db-user-pass" {
  name        = "/203/database/password/user"
  description = "User password for bookstore_db"
  type        = "SecureString"
  value       = var.db-user-pass
}

resource "aws_ssm_parameter" "db-root-pass" {
  name        = "/203/database/password/root"
  description = "Root password for bookstore_db"
  type        = "SecureString"
  value       = var.db-root-pass
}