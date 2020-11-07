resource "aws_autoscaling_policy" "jellyfish" {
  name                   = "jellyfish"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.jellyfish.name
}

resource "aws_autoscaling_group" "jellyfish" {
  availability_zones        = ["us-east-1a"]
  name                      = "jellyfish-asg"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = aws_lb_target_group.jellyfish.arn
  launch_configuration      = aws_launch_configuration.jellyfish.name
}

resource "aws_lb_target_group" "jellyfish" {
  name     = "jellyfish-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.jellyfish.id
}

