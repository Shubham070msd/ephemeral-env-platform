# Application Load Balancer
resource "aws_lb" "main" {
  name               = "ephemeral-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
  security_groups    = [aws_security_group.ecs_sg.id]
  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  tags = {
    Name = "ephemeral-lb"
  }
}

# Target Group (for port 80)
resource "aws_lb_target_group" "main" {
  name        = "ephemeral-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
