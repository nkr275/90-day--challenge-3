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
  default = "vpc-0f27d08d0fc50"
}

variable "security_group_id" {
  type =  string
  default = "sg-005d3605c6"
}
variable "my_igw" {
  type =  string
  default = "igw-0fa8dcbb92c"
}
variable "subnet_id1" {
  type =  string
  default = "subnet-0c0f36f12f"
}
variable "subnet_id2" {
  type =  string
  default = "subnet-01c0b55cd3"
}
variable "subnet_id3" {
  type =  string
  default = "subnet-0d0c2f0a45465"
}


