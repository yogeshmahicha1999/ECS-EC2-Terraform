resource "aws_lb" "alb" {
  name               = var.alb_Name
  load_balancer_type = var.alb_type
  internal           = false
  subnets            = ["${aws_subnet.public1.id}", "${aws_subnet.public2.id}", "${aws_subnet.public3.id}"]
  tags = {
    "env"       = "var.app_environment"
    "createdBy" = "load-balancer"
  }
  security_groups = [aws_security_group.alb.id]
}

resource "aws_lb_target_group" "alb_target_group" {
  name        = var.target_group_name
  port        = var.tg_port
  protocol    = "HTTP"
  target_type = var.tg_type
  vpc_id      = aws_vpc.trf_vpc.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.tg_port
  protocol          = var.tg_listner_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

