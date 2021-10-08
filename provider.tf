terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
    region  = "us-east-1"
    profile = "default"
    
    }

resource "tls_private_key" "webserver_private_key" {
 algorithm = "RSA"
 rsa_bits = 4096
}
resource "aws_key_pair" "webserver_key" {
 key_name = "webserver"
 public_key = tls_private_key.webserver_private_key.public_key_openssh
}