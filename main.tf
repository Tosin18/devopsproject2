resource "aws_key_pair" "tkey" {
  key_name   = "tkey"
  public_key = file(var.dir_to_public_key)
}

resource "aws_instance" "devopstrain" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = var.subnet_id
  key_name = "tkey"

  tags = {
    Name = "DevOps Build"
  }

  resource "aws_security_group" "security_group" {
  name = "security"
  vpc_id = var.aws_vpc.vpc.id
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

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
      ]

    }

  }

}