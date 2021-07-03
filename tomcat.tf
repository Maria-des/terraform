# Provider

resource "aws_instance" "InstanceTomcat" {
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
    inline = [
      "sudo hostnamectl set-hostname tomcat",
      "sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm",
      "sudo dnf config-manager --set-enabled codeready-builder-for-rhel-8-rhui-rpms",
      "sudo dnf install -y ansible",
      "ansible --version"
    ]
  } 

  tags = {
    #Name  = "Instance${count.index + 1}"
    Name = "InstanceTomcat"
  }
}

