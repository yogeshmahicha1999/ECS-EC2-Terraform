resource "aws_ecs_cluster" "web-cluster" {
  name = var.ecs_cluster

  tags = {
    "env"       = "dev"
    "createdBy" = "cluster"
  }
}

################################## Task-Defination ############################

resource "aws_ecs_task_definition" "task_define-test" {
  family                   = var.task_family_name
  requires_compatibilities = ["EC2"]
  network_mode             = var.service_network_mode
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn
  container_definitions = <<DEFINITION
[
    {
        "name": "${var.container_name}",
        "image": "${aws_ecr_repository.demo-repository.repository_url}",
        "essential": true,
	"memoryreservation": 130,
        "portMappings": [
            {
                "protocol": "tcp",
                "containerPort": 80
            }
        ]
    }
   ]
    DEFINITION
}

######################################### Service ####################################

resource "aws_ecs_service" "service" {
  name            = var.ecs_service_name
  launch_type     = var.launch_type //"EC2"
  cluster         = aws_ecs_cluster.web-cluster.id
  task_definition = aws_ecs_task_definition.task_define-test.arn
  desired_count   = var.Service_desired_count
  ordered_placement_strategy {
    type  = (var.ordered_placement_strategy_type)
    field = (var.ordered_placement_strategy_field)
  }
  network_configuration {
    security_groups = ["${aws_security_group.ecs.id}"]
    subnets         = flatten(["${aws_subnet.private1.id}","${aws_subnet.private2.id}"])
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    container_name   = var.container_name
    container_port   = 80

  }
  
  depends_on = [aws_lb_listener.listener, aws_iam_role_policy_attachment.ecsTaskExecutionRole-attachment]
}




 resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.web-cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}



resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  name               = "memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
 
  target_tracking_scaling_policy_configuration {
   predefined_metric_specification {
    predefined_metric_type = "ECSServiceAverageMemoryUtilization"
   }
    scale_out_cooldown = 30
    scale_in_cooldown = 30
    target_value       = 10
    
  }
}
 
resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
 
  target_tracking_scaling_policy_configuration {
   predefined_metric_specification {
    predefined_metric_type = "ECSServiceAverageCPUUtilization"
   }
    scale_out_cooldown = 30
    scale_in_cooldown = 30
    target_value       = 10
    
  }
}


