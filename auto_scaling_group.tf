resource "aws_launch_configuration" "ASG_openmrs" {
  name_prefix = "ASG-launch-config-"
  image_id = "ami-07275c9a70" #Ubuntu 16.04 LTS
  #image_id = "ami-b70554c8" #Amazon Linux 2
  associate_public_ip_address      = true
  instance_type = "t2.micro"
  security_groups = ["${data.aws_security_group.my_sg.id}"]
  key_name = "oregon"
  user_data = <<-EOF
             #!/bin/bash -xe
              echo "Hello, World" 
              sudo apt update 
             sudo mysql -uopenmrsDB -hmysql.cclkfmqdcizd.us-west-2.rds.amazonaws.com -p'openmrsDB275'
             \q
             EOF  
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "openmrs" {
  name                      = "foobar3-terraform-test"
  max_size                  = 5
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [ "${aws_elb.openmrs_elb.name}" ]
  force_delete              = true
  launch_configuration      = aws_launch_configuration.ASG_openmrs.name
  vpc_zone_identifier       = ["${data.aws_subnet.subnet1.id}", "${data.aws_subnet.subnet2.id}", "${data.aws_subnet.subnet3.id}"]

  tag {
    key                 = "ASG"
    value               = "ec2-openmrs"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "asg-policy" {
  name                   = "foobar3-terraform-test"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.openmrs.name
}