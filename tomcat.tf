# Provider

resource "aws_instance" "InstanceTomcat" {
  key_name      = aws_key_pair.example.key_name
  #count         = var.instance_count
  ami		 = "ami-0b0af3577fe5e3532"
  #instance_type = "t2.micro"
  instance_type = var.instance_type
  
  #connection {
  #  type        = "ssh"
  #  user        = "ec2-user"
  #  private_key = file("~/.ssh/terraform")
  #  #host        = self.public_ip
  #}
  
  provisioner "remote-exec" {
    inline = [
        "sudo amazon-linux-extras enable tomcat",
        "sudo yum -y install tomcat"
    #  #"sudo systemctl start nginx"
    ]
  } 

  tags = {
    #Name  = "Instance${count.index + 1}"
    Name = "InstanceTomcat"
  }
}

