resource "aws_elb" "openmrs_elb" {
  name               = "elb-tf"
  internal           = false
  security_groups    = ["${data.aws_security_group.my_sg.id}"]
  subnets            = ["${data.aws_subnet.subnet1.id},${data.aws_subnet.subnet1.id},${data.aws_subnet.subnet1.id}"]
  listener {
      instance_port = 80
      instance_protocol = "http"
      lb_port   =   80
      lb_protocol = "http"
  }
  listener {
      instance_port = 8080
      instance_protocol = "http"
      lb_port   =   8080
      lb_protocol = "http"
  }
  health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 3
      target = "HTTP:8080/"
      interval = 6
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  
  tags = {
    Name = "my-elb"
  }
}
