output "external-elb" {
  value = aws_lb.external-elb
}
output "lb_route53_name" {
  #   count       = length(var.public_cidrs)
  description = "The route53 name of the load balancer"
  value       = aws_lb.external-elb.dns_name
}