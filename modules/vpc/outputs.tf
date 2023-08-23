# --- vpc/outputs.tf ---
# output "design_sg" {
#   value = aws_security_group.design-sg.id
# }
# output "vpc_security_group_ids" {
#   value = aws_security_group.design-sg.id
# }
output "external-elb" {
  value = aws_lb.external-elb
}
output "lb_route53_name" {
  #   count       = length(var.public_cidrs)
  description = "The route53 name of the load balancer"
  value       = aws_lb.external-elb.dns_name
}


