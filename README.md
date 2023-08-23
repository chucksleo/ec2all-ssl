# terraform for infra team

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

#######################################

SAMPLE tfvars

aws_region          = "us-east-2"                         // declare region
vpc_id              = "vpc-0d11dbb886d23afa1"             // vpc_id of existing vpc needed here
public_1            = "subnet-0eb47dd08b2f6c423"          // public 1 subnet ID must be identfied for existing vpc
public_2            = "subnet-0614f65713c4f382a"          // public 2 subnet ID must be identfied for existing vpc
record_name         = "tenjin"                            // DNS record to be issued the complete URL=record_name.domain_anme
domain_name         = "*.cloud1.saicds.com"               // This is the value of the certificate issued by ACM
zone_name           = "cloud1.saicds.com"                 // ZONE must exist prior or NEED TO CREATE
ami_id              = "ami-06cd72ee2d89fec36"             // ami id - change to dataiku version created by packer either design or api as needed
instance_class      = "r6a.xlarge"                        // ec2 insatnce class 
key_name            = "tenjin-us-east-2"                  // key name neads to be existing
instance_name       = "tenjin-cdp-team"                   // This is what shows up in console
name_prefix         = "tenjin-cdp-team-"                  // taggin prefix for resources created
name_suffix         = "design"                            // taging suffix to identify componet design or api or??/
resource_tags = {
       Schedule     = "us-office-hours"             
       Application  = "Dataiku"                           // tag for cost reports - specify Dataiku or Koverse or ??
       Environment  = "Sandbox"                           // tag for cost reports - specify where



}