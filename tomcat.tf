# Provider

resource "aws_instance" "InstanceTomcat" {
  key_name      = aws_key_pair.example2.key_name
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
  
  provisioner "file" {
    source = "tomcat.yaml"
    destination = "/tmp/tomcat.yaml"
  }
  
  provisioner "file" {
    source = "~/.ssh/id_rsa"
    destination = "~/.ssh/id_rsa"
  }

  provisioner "file" {
    source = "~/.ssh/id_rsa.pub"
    destination = "~/.ssh/id_rsa.pub"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname tomcat",
      "sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm",
      "sudo dnf config-manager --set-enabled codeready-builder-for-rhel-8-rhui-rpms",
      "sudo dnf install -y ansible",
      "chmod 600 ~/.ssh/id_rsa",
      "echo ${self.private_ip} >> /tmp/lista"
    ]
  } 

  tags = {
    #Name  = "Instance${count.index + 1}"
    Name = "InstanceTomcat"
  }
}

