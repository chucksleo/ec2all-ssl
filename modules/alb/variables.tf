variable "target_id" {}
variable "certificate_arn" {}
variable "vpc_id" {
  type = string
}
variable "public_1" {}
variable "public_2" {}
variable "name_prefix" {}
variable "name_suffix" {}
variable "design_sg" {
  type = string
}
variable "protocol" {}
variable "port" {}
variable "lb_type" {}