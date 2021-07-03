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

resource "aws_key_pair" "example" {
  key_name   = "examplekey"
  public_key = file("~/.ssh/id_rsa.pub")
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
  #region  = "us-east-1"
  region = var.aws_region
}

resource "aws_instance" "InstanceMysql" {
  key_name      = aws_key_pair.example.key_name
  #count         = var.instance_count
  ami		 = "ami-0b0af3577fe5e3532"
  #instance_type = "t2.micro"
  instance_type = var.instance_type
  
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
  
  provisioner "remote-exec" {
    #connection {
    #type        = "ssh"
    #user        = "ec2-user"
    #private_key = file("~/.ssh/terraform")
    #host        = "${element(aws_instance.Instance*.public_ip, count.index)}"
    #host        = self.public_ip
    inline = [
        "sudo hostnamectl set-hostname mysql",
        "sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm",
	"sudo dnf config-manager --set-enabled codeready-builder-for-rhel-8-rhui-rpms",
	"sudo dnf install -y ansible",
	"ansible --version"
    ]
  } 

  tags = {
    #Name  = "Instance${count.index + 1}"
    Name = "InstanceMySql"
  }
}

