resource "aws_key_pair" "tkey" {
  key_name   = "tkey"
  public_key = file(var.dir_to_public_key)
}

resource "aws_instance" "devopstrain" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = "tkey"


  tags = {
    Name = "DevOps Build"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.devopstrain.public_ip
      private_key = file(var.dir_to_private_key)
    }

    inline = [
      "sudo yum update -y",
      "sudo yum install git -y",
      "sudo yum update -y",
      "sudo yum install java-1.8.0-openjdk -y ",
      "sudo yum install maven -y",
      "sudo amazon-linux-extras enable nginx1.12",
      "yum clean metadata",
      "yum install nginx",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      "sudo yum install tomcat -y",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo",
      "sudo rpm --import http://pkg.jenkins.io/redhat/jenkins.io.key",
      "sudo yum install jenkins -y",
    ]


  }
}