# Provider

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
  access_key = "AKIAYEEOWZR2SMB7RCT6"
  secret_key = "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"
  region = "us-east-1"
}

resource "aws_instance" "mysql_host" {
  #ami           = "ami-01fc429821bf1f4b4"
  ami		 = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"

  tags = {
    Name = "InstanceMySql"
  }
}
