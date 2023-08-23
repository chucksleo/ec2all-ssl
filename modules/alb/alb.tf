resource "aws_lb" "external-elb" {
  name               = "${var.name_prefix}-${var.name_suffix}-alb"
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [var.design_sg]
  subnets            = [var.public_1, var.public_2]

}

resource "aws_lb_target_group" "external-elb" {
  name     = "${var.name_prefix}-${var.name_suffix}-TG"
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id
  tags = {
    Name   = "${var.name_prefix}-${var.name_suffix}-target-group"
  }
}

resource "aws_lb_target_group_attachment" "external-elb1" {
  target_group_arn = aws_lb_target_group.external-elb.arn
  target_id        = var.target_id
  port             = 443

}


