# Terraform Configuration for infra team

# EC2 Instance Infrastructure Setup

This repository contains the Terraform configuration to set up EC2 instances along with associated security groups in AWS. The defined EC2 instances include:

1. Design Server: An EC2 instance for design-related tasks.
2. Govern Server: An EC2 instance for governance-related tasks.
3. Automation Server: An EC2 instance for automation tasks.

Each EC2 instance is associated with a specific Amazon Machine Image (AMI) and configured with the necessary networking settings.


# PRE REQ 

Before you begin, ensure you have the following prerequisites.

- dns zone needed before this script will work
- export AWS_PROFILE=myprofile

# HOW TO USE
- the tfvars file is the only file to enter values
- rename to the specifc deployment as needed

edit *.tfvars to populate the ec2-route53-vpc modules
this will 
- install a design server into an existing vpc
- create ALB
- create route 53 records

## Usage

# SAMPLE tfvars
```hcl
aws_region          = "us-west-2"                         // declare region
vpc_id              = "vpc-0494f60f28c01748b"             // vpc_id of existing vpc needed here
public_1            = "subnet-0b16e3776fbd5d656"          // public 1 subnet ID must be identfied for existing vpc
public_2            = "subnet-024b2208671b62d03"          // public 2 subnet ID must be identfied for existing vpc
record_name         = "sheuntestdesign"                            // DNS record to be issued the complete URL=record_name.domain_anme
domain_name         = "*.test.saicds.com"                // This is the value of the certificate issued by ACM
zone_name           = "test.saicds.com"                 // ZONE must exist prior or NEED TO CREATE
ami_id_d              = "ami-00fa6d7a4eabea542"             // ami id - change to dataiku version created by packer either design or api as needed
ami_id_a              = "ami-035c1ec1ece0bbe4b"             // ami id - change to dataiku version created by packer either design or api as needed
ami_id_g              = "ami-00884fec3a3467984"             // ami id - change to dataiku version created by packer either design or api as needed
instance_class      = "r6a.xlarge"                        // ec2 insatnce class 
key_name            = "sheuntest-us-west-2"                  // key name neads to be existing
instance_name_d       = "sheun_test_design_ec2"                   // This is what shows up in console
instance_name_a       = "sheun_test_automate_ec2"                   // This is what shows up in console
instance_name_g       = "sheun_test_govern_ec2"                   // This is what shows up in console
name_prefix         = "sheuntest"                  // taggin prefix for resources created
name_suffix         = "packer"                            // taging suffix to identify componet design or api or??/
resource_tags = {
       Schedule     = "us-office-hours"             
       Application  = "packer"                           // tag for cost reports - specify Dataiku or Koverse or ??
       Environment  = "test"                           // tag for cost reports - specify where
       Project = "Project"                            // tag for cost reports - specify the project
}
```

# SAMPLE ec2
```
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
}```