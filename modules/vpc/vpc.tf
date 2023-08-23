# Installs into a existing VPC

# Create Public Security Group
# resource "aws_security_group" "design-sg" {
#   name        = "${var.name_prefix}-${var.name_suffix}-SG"
#   description = "Allow HTTP inbound traffic"
#   vpc_id      = var.vpc_id

#   ingress {
#     description = "HTTP from VPC"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "SSH from VPC"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "HTTPS from VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "design-SG"
#   }
# }

# # Create Private Security Group
# resource "aws_security_group" "alb-design-sg" {
#   name        = "${var.name_prefix}-${var.name_suffix}-alb-SG"
#   description = "Allow inbound traffic from ALB"
#   vpc_id      = var.vpc_id

#   ingress {
#     description     = "Allow traffic from web layer"
#     from_port       = 80
#     to_port         = 80
#     protocol        = "tcp"
#     security_groups = [aws_security_group.design-sg.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "alb-design-SG"
#   }
# }

# data "aws_security_group" "this" {
#   name = "${var.name_prefix}-${var.name_suffix}-SG" 
# }


#create internet facing ALB
resource "aws_lb" "external-elb" {
  name               = "${var.name_prefix}-${var.name_suffix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.design_sg]
  subnets            = [var.public_1, var.public_2]

}

resource "aws_lb_target_group" "external-elb" {
  name     = "${var.name_prefix}-${var.name_suffix}-TG"
  port     = 443
  protocol = "HTTPS"
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

resource "aws_lb_listener" "external-elb1" {
  load_balancer_arn = aws_lb.external-elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"

    }
  }
}

resource "aws_lb_listener" "external-elb2" {
  load_balancer_arn = aws_lb.external-elb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.external-elb.arn
  }
}
