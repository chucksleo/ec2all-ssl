#Create EC2 Instance
resource "aws_instance" "design-server" {
  instance_type          = var.instance_class
  ami                    = var.ami_id_d
  key_name               = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  subnet_id              = var.public_1
  volume_tags            = var.resource_tags
  
  tags = merge(
    {
      Name = var.instance_name_d
    },
    var.resource_tags
  )

}

resource "aws_instance" "govern-server" {
  instance_type          = var.instance_class
  ami                    = var.ami_id_g
  key_name               = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  subnet_id              = var.public_1
  volume_tags            = var.resource_tags
  
  tags = merge(
    {
      Name = var.instance_name_g
    },
    var.resource_tags
  )

}

resource "aws_instance" "automation-server" {
  instance_type          = var.instance_class
  ami                    = var.ami_id_a
  key_name               = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  subnet_id              = var.public_1
  volume_tags            = var.resource_tags
  
  tags = merge(
    {
      Name = var.instance_name_a
    },
    var.resource_tags
  )

}

  resource "aws_security_group" "prod-default" {
  name_prefix = "${var.name_prefix}-${var.name_suffix}"
  description = "Design security group"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name_suffix} default sec group"
  }

  }
