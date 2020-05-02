
# scale up
resource "aws_autoscaling_policy" "as_policy_up" {
  name                   = "foobar3-terraform-test"
  autoscaling_group_name = aws_autoscaling_group.openmrs.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  
}
resource "aws_cloudwatch_metric_alarm" "CPU-alarm-up" {
  alarm_name          = "CPU_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.openmrs.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.as_policy_up.arn}"]
}
# scale down
resource "aws_autoscaling_policy" "as_policy_down" {
  name                   = "foobar3-terraform-test"
  autoscaling_group_name = aws_autoscaling_group.openmrs.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  
}
resource "aws_cloudwatch_metric_alarm" "CPU-alarm-down" {
  alarm_name          = "CPU_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "35"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.openmrs.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.as_policy_down.arn}"]
}
