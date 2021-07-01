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

variable "instance_count" {
  default = "2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "Instance_mysql" {
  count         = var.instance_count
  ami		 = "ami-0b0af3577fe5e3532"
  #instance_type = "t2.micro"
  instance_type = var.instance_type


  tags = {
    Name  = "Instance${count.index + 1}"
    #Name = "InstanceMySql"
  }
}

