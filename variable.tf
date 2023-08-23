variable "vpc_id"{
type = string
}
variable "record_name" {
    type = string
}
variable "domain_name" {
    type = string
}
variable "zone_name" {
    type = string
}
variable "ami_id_a" {
  type = string
}
variable "ami_id_g" {
  type = string
}
variable "ami_id_d" {
  type = string
}
variable "instance_class" {
  type = string
}
variable "key_name" {
  type = string
}
variable "public_1" {
  type = string
}
variable "public_2" {
  type = string
}
variable "aws_region" {
  description = "The AWS region to use."
  type = string
}
variable "instance_name_a" {
  type = string
}
variable "instance_name_g" {
  type = string
}
variable "instance_name_d" {
  type = string
}
variable "resource_tags" {
  type = map(string)
  default = {
    Tag1 = "Value1"
    Tag2 = "Value2"
    Tag3 = "Value3"
  }
}
variable "name_prefix" {
  type    = string
  default = ""
}
variable "name_suffix" {
  type    = string
  default = ""
}

variable "bucket_name" {
  type = string
  default = ""
  
}

variable "sg_description" {
  description = "The description of the security group"
  type        = string
}

# variable "design_sg" {
#   type = string
# }

# variable "vpc_id" {
#   description = "The ID of the VPC"
#   type        = string
# }

variable "ingress_rules" {
  description = "List of ingress rules"
  type        = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "egress_rules" {
  description = "List of egress rules"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "sg_tag" {
  description = "The tag name of the security group"
  type        = string
}