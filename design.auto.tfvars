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
bucket_name = "sheuntest-design-s3"
sg_description = "Allow HTTP inbound traffic"
ingress_rules = [
  {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
] 

egress_rules = [ 
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]  
sg_tag = "sheun-sg-module"