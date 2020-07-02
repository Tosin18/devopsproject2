variable "region" {
  default = "eu-west-1"
}
variable "ami_id" {
  default = "ami-0ea3405d2d2522162"
}

variable "dir_to_public_key" {
  default = "tkey.pub"
}

variable "dir_to_private_key" {
  default = "tkey"
}

variable "aws_subnet_public_id" { default = "subnet-d7eb848d" }

variable "vpc_security_group" {
  default = "vpc_security_group_id"
}

variable "vpc_id_vpc_id" {
  default = "vpc-14cb3b6d"
}