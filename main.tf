resource "aws_key""tkey"{
    key_name = "tkey"
    public_key = file(var.dir_to_public_key)

}
resource "aws_instance" "devopsproj"{
    ami  = var.ami_id
    instance_type = "t2.micro"
    key_name= "tkey"
}

tags "DevOps" ={
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
     ]
 
   } 
 
  }