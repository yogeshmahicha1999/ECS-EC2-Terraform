######################################## ALB-security ##########################

resource "aws_security_group" "alb" {
  name   = var.aws_security_group_alb
  vpc_id = aws_vpc.trf_vpc.id
  ingress {
    from_port   = var.ingress_http
    to_port     = var.ingress_http
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_allow_cidr}"]
  }
  ingress {
    from_port   = var.ingress_https
    to_port     = var.ingress_https
    protocol    = "tcp"
    cidr_blocks = ["${var.ingress_allow_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.ingress_allow_cidr}"]
  }

  tags = {
    "env"       = "$var.app_environment"
    "createdBy" = "security-group"
  }

}


######################################### ECS-security #################################

resource "aws_security_group" "ecs" {
  name   = var.aws_security_group_ecs
  vpc_id = aws_vpc.trf_vpc.id
  ingress {
    from_port       = var.ingress_http
    to_port         = var.ingress_http
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb.id}"]
  }

  #    ingress {
  #    from_port   = "${var.ingress_ssh}"
  #    to_port     = "${var.ingress_ssh}"
  #    protocol    = "tcp"
  #    cidr_blocks = ["${var.ingress_allow_custom}"]
  #  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.ingress_allow_cidr}"]
  }

  tags = {
    "env"       = "var.app_environment"
    "createdBy" = "ecs"
  }

}


