variable "access" {
  type = string
}

variable "secret" {
  type = string
}

variable "region" {
  type =  string
}

variable "vpc_id" {
  type =  string
  default = "vpc-0f27d08d0fc5"
}

variable "security_group_id" {
  type =  string
  default = "sg-005d3605c6e"
}
variable "my_igw" {
  type =  string
  default = "igw-0fa8dcbb92c"
}
variable "subnet_id1" {
  type =  string
  default = "subnet-0c0f36f12f6"
}
variable "subnet_id2" {
  type =  string
  default = "subnet-01c0b55cd3a4"
}
variable "subnet_id3" {
  type =  string
  default = "subnet-0d0c2f0a4546"
}


