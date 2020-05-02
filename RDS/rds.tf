resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "mysql5.7"
  description = "MysqlDB parameter group"

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
resource "aws_db_subnet_group" "mysql-subnet" {
  name       = "mysql-subnet"
  subnet_ids = ["${data.aws_subnet.subnet1.id}", "${data.aws_subnet.subnet2.id}", "${data.aws_subnet.subnet3.id}"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_security_group" "allow_mysql" {
    name            = "my_sg_mysql"
    description     = "created from terraform"
    vpc_id          = data.aws_vpc.my_network.id
    ingress{
        protocol    = "tcp"
        from_port   = "3306"
        to_port     = "3306"
        security_groups    = ["${data.aws_security_group.my_sg.id}"]
    }
    egress{
        cidr_blocks = ["0.0.0.0/0"]
        protocol    = "-1"
        from_port   = "0"
        to_port     = "0"
    }
    tags = {
        Name = "allow-mysqldb"
    }
}
  
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "mysql"
  name                 = "mydb"
  username             = " "
  password             = " "
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.mysql-subnet.name
  multi_az             = "false" 
  vpc_security_group_ids =["${aws_security_group.allow_mysql.id}"] 
  backup_retention_period = 30
  
}
