# --- route53/outputs.tf ---

output "certificate_arn" {
  value = aws_acm_certificate_validation.route53.certificate_arn
}
