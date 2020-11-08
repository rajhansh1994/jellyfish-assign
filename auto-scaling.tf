/*Here we have the following configuration:

There will be minimum one instance to serve the traffic
Auto Scaling Group will be launched with 2 instances and put each of them in separate Availability Zones in different Subnets
Auto Scaling Group will get information about instance availability from the ELB
We’re set up collection for some Cloud Watch metrics to monitor our Auto Scaling Group state
Each instance launched from this Auto Scaling Group will have Name tag set to jellyfish*/



resource "aws_autoscaling_group" "jellyfish" {
  name = "${aws_launch_configuration.jellyfish.name}-asg"

  min_size         = 1
  desired_capacity = 2
  max_size         = 4

  health_check_type = "ELB"
  load_balancers = [
    aws_elb.jellyfish_elb.id
  ]

  launch_configuration = aws_launch_configuration.jellyfish.name

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier = [
    aws_subnet.public_us_east_1a.id,
    aws_subnet.public_us_east_1b.id
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "jellyfish"
    propagate_at_launch = true
  }

}