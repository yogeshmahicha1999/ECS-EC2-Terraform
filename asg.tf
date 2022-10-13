resource "aws_launch_configuration" "ecs-launch-configuration" {

  name                 = var.ecs_lc_name
  image_id             = var.ami_id
  instance_type        = var.ec2_instance
  iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.id

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  security_groups             = ["${aws_security_group.ecs.id}"]
  associate_public_ip_address = "false"

  user_data                   = <<EOF
                                  #!/bin/bash
                                  echo ECS_CLUSTER="${aws_ecs_cluster.web-cluster.name}" >> /etc/ecs/ecs.config;echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config
                                  EOF
}
 

resource "aws_autoscaling_group" "ecs-autoscaling-group" {
  name                 = var.asg_name
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = ["${aws_subnet.private1.id}", "${aws_subnet.private2.id}"]
  launch_configuration = aws_launch_configuration.ecs-launch-configuration.name
  health_check_grace_period = 300
  health_check_type    = "ELB"
  termination_policies = ["NewestInstance"]
  instance_refresh {
    strategy = "Rolling"
    preferences {
      // You probably want more than 50% healthy depending on how much headroom you have
      min_healthy_percentage = 50
    } 
  }  
}
