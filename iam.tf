################################## ECS-Role ############################

# ECS task execution role data

data "aws_iam_policy_document" "ecs" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "ecs" {
  assume_role_policy = data.aws_iam_policy_document.ecs.json
  name               = "ecs-InstanceRole"
}

resource "aws_iam_role_policy_attachment" "ecs" {
  role       = "${aws_iam_role.ecs.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "ecs-Profile"
  role = "${aws_iam_role.ecs.name}"
}


################################# Task-DEfination #########################################

data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


# ECS task execution role
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = var.ecs_ExecutionRole_name
  assume_role_policy = data.aws_iam_policy_document.ecs-service-policy.json
}

# ECS task execution role policy attachment
resource "aws_iam_role_policy_attachment""ecsTaskExecutionRole-attachment" {
  role       = "${aws_iam_role.ecsTaskExecutionRole.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



