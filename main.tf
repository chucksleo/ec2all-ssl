module "vpc" {
  source             = "./modules/vpc"
  vpc_id             = var.vpc_id
  certificate_arn    = module.route53.certificate_arn
  target_id          = module.ec2.design-server_id
  public_1           = var.public_1
  public_2           = var.public_2
  name_prefix        = var.name_prefix
  name_suffix        = var.name_suffix
  design_sg = module.sg.design_sg
}

module "ec2" {
  source                 = "./modules/ec2"
  key_name               = var.key_name
  ami_id_a                 = var.ami_id_a
  ami_id_d                 = var.ami_id_d
  ami_id_g                 = var.ami_id_g
  instance_class         = var.instance_class
  public_1               = var.public_1
  design_sg              = module.sg.design_sg
  vpc_security_group_ids = module.sg.vpc_security_group_ids
  resource_tags          = var.resource_tags
  instance_name_a          = var.instance_name_a
  instance_name_d          = var.instance_name_d
  instance_name_g          = var.instance_name_g
  name_prefix            = var.name_prefix
  name_suffix            = var.name_suffix
}

module "route53" {
  source           = "./modules/route53"
  domain_name      = var.domain_name
  environment_name = "Dev"
  zone_name        = var.zone_name
  record_name      = var.record_name
  alias_name       = module.alb.external-elb.dns_name
  alias_zone_id    = module.alb.external-elb.zone_id
}


module "s3" {
  source           = "./modules/s3"
  bucket_name      = var.bucket_name
  name_prefix            = var.name_prefix
  name_suffix            = var.name_suffix
  

}

module "sg" {
  source          = "./modules/sg"
  #sg_name            = module.sg.aws_security_group.name
  sg_description     = var.sg_description
  vpc_id          = var.vpc_id
  ingress_rules   = var.ingress_rules
  egress_rules    = var.egress_rules
  name_prefix            = var.name_prefix
  name_suffix            = var.name_suffix
  sg_tag          = var.sg_tag
}

module "alb"{
  source = "./modules/alb"
  vpc_id             = var.vpc_id
  certificate_arn    = module.route53.certificate_arn
  target_id          = module.ec2.design-server_id
  design_sg = module.sg.design_sg
  port = var.port
  lb_type =  var.lb_type
  protocol = var.protocol
}