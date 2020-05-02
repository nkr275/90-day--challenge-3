data "aws_vpc" "my_network" {
  id = var.vpc_id
}
data "aws_subnet" "subnet1" {
  id = var.subnet_id1
  availability_zone = "us-west-2a"
}
data "aws_subnet" "subnet2" {
  id = var.subnet_id2
  availability_zone = "us-west-2b"
}
data "aws_subnet" "subnet3" {
  id = var.subnet_id3
  availability_zone = "us-west-2c"
}

data "aws_internet_gateway" "my_igw" {
    internet_gateway_id = var.my_igw
  filter {
    name   = "attachment.vpc-id"
    values = ["${data.aws_vpc.my_network.id}"]
  }
}
data "aws_security_group" "my_sg" {
  id = var.security_group_id
}
