provider "aws" {
  region = "us-east-1"
}

# Make VPC
module "vpc" {
  source = "./modules/vpc"
  cidr   = "10.0.0.0/16"
  tags = merge(
    {
      "Name" = format("%s_vpc", var.name)
    },
    var.tags,
  )
}

# Make public subnet
module "public_subnet" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  az_id      = "use1-az4" #us-east1d
  cidr       = "10.0.0.0/18"
  map_pub_ip = true
  tags = merge(
    {
      "Name" = format("%s_public_subnet", var.name)
    },
    var.tags,
  )
}

# Make private subnet 1
module "private_subnet_1" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  az_id      = "use1-az5" #us-east1e
  cidr       = "10.0.64.0/18"
  map_pub_ip = false
  tags = merge(
    {
      "Name" = format("%s_private_subnet_1", var.name)
    },
    var.tags,
  )
}

# Make private subnet 2
module "private_subnet_2" {
  source     = "./modules/subnet"
  vpc_id     = module.vpc.vpc_id
  az_id      = "use1-az6" #us-east1f
  cidr       = "10.0.128.0/18"
  map_pub_ip = false
  tags = merge(
    {
      "Name" = format("%s_private_subnet_2", var.name)
    },
    var.tags,
  )
}

# Make Internet gateway and NAT Gateway
module "gateways" {
  source        = "./modules/internet_nat_gateways"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.public_subnet.subnet_id
  allocation_id = "eipalloc-018e8daad1c379760"
  igw_tags = merge(
    {
      "Name" = format("%s_igw", var.name)
    },
    var.tags,
  )
  nat_tags = merge(
    {
      "Name" = format("%s_nat", var.name)
    },
    var.tags,
  )
}

# Make first route table which will have Internet gateway entry
module "route_table_1" {
  source     = "./modules/route_table"
  igw_source = true
  vpc_id     = module.vpc.vpc_id
  igw_id     = module.gateways.igw_id
  tags = merge(
    {
      "Name" = format("%s_route_table_1", var.name)
    },
    var.tags,
  )
}

# Make second route table which will have NAT entry
module "route_table_2" {
  source     = "./modules/route_table"
  igw_source = false
  vpc_id     = module.vpc.vpc_id
  nat_id     = module.gateways.nat_id
  tags = merge(
    {
      "Name"       = format("%s_route_table_2", var.name)
    },
    var.tags,
  )
}

# Associate public subnet with Internet Gateway route table
module "public_associate" {
  source         = "./modules/associate_subnet_route"
  subnet_id      = module.public_subnet.subnet_id
  route_table_id = module.route_table_1.igw_route_table_id
}

# Associate private subnet 1 with NAT route table
module "private_1_associate" {
  source         = "./modules/associate_subnet_route"
  subnet_id      = module.private_subnet_1.subnet_id
  route_table_id = module.route_table_2.nat_route_table_id
}

# Associate private subnet 2 with NAT route table
module "private_2_associate" {
  source         = "./modules/associate_subnet_route"
  subnet_id      = module.private_subnet_2.subnet_id
  route_table_id = module.route_table_2.nat_route_table_id
}

# Create security group for public ec2 instance
module "public_ec2_sg" {
  source      = "./modules/security_group"
  name        = "public_ec2_sg"
  description = "Allows SSH from Quantiphi IP"
  vpc_id      = module.vpc.vpc_id
  tags = merge(
    {
      "Name" = format("%s_public_ec2_sg", var.name)
    },
    var.tags,
  )
}

# Ingress rule for public EC2 which only allows SSH from my IP
module "public_ec2_sg_ingress" {
  source      = "./modules/security_group_rule"
  sg_source   = false
  type        = "ingress"
  sg_id       = module.public_ec2_sg.sg_id
  cidr_blocks = ["59.152.53.203/32"]
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
}

# Egress rule for public EC2 which only allows HTTP for package updates
module "public_ec2_sg_egress_1" {
  source      = "./modules/security_group_rule"
  sg_source   = false
  type        = "egress"
  sg_id       = module.public_ec2_sg.sg_id
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Egress rule for private EC2 which only allows HTTPS for package updates
module "public_ec2_sg_egress_2" {
  source      = "./modules/security_group_rule"
  sg_source   = false
  type        = "egress"
  sg_id       = module.public_ec2_sg.sg_id
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Create security group for private ec2 instance
module "private_ec2_sg" {
  source      = "./modules/security_group"
  name        = "private_ec2_sg"
  description = "Allows SSH from public EC2"
  vpc_id      = module.vpc.vpc_id
  tags = merge(
    {
      "Name" = format("%s_private_ec2_sg", var.name)
    },
    var.tags,
  )
}

# Ingress rule for private EC2 which only allows SSH from public ec2 instance
module "private_ec2_sg_ingress" {
  source       = "./modules/security_group_rule"
  sg_source    = true
  type         = "ingress"
  sg_id        = module.private_ec2_sg.sg_id
  source_sg_id = module.public_ec2_sg.sg_id
  from_port    = 22
  to_port      = 22
  protocol     = "tcp"
}

# Egress rule for private EC2 which only allows HTTP for package updates
module "private_ec2_sg_egress_1" {
  source      = "./modules/security_group_rule"
  sg_source   = false
  type        = "egress"
  sg_id       = module.private_ec2_sg.sg_id
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Egress rule for private EC2 which only allows HTTPS for package updates
module "private_ec2_sg_egress_2" {
  source      = "./modules/security_group_rule"
  sg_source   = false
  type        = "egress"
  sg_id       = module.private_ec2_sg.sg_id
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Egress rule for private EC2 which allows MySQL connection with private RDS instance
module "private_ec2_sg_egress_3" {
  source       = "./modules/security_group_rule"
  sg_source    = true
  type         = "egress"
  sg_id        = module.private_ec2_sg.sg_id
  from_port    = 3306
  to_port      = 3306
  protocol     = "tcp"
  source_sg_id = module.private_rds_sg.sg_id
}

# Security group for private RDS instance
module "private_rds_sg" {
  source      = "./modules/security_group"
  name        = "private_rds_sg"
  description = "Allows connection from private EC2"
  vpc_id      = module.vpc.vpc_id
  tags = merge(
    {
      "Name" = format("%s_private_rds_sg", var.name)
    },
    var.tags,
  )
}

# Ingress rule for private RDS which only allows connection from private ec2 instance
module "private_rds_sg_ingress" {
  source       = "./modules/security_group_rule"
  sg_source    = true
  type         = "ingress"
  sg_id        = module.private_rds_sg.sg_id
  source_sg_id = module.private_ec2_sg.sg_id
  from_port    = 3306
  to_port      = 3306
  protocol     = "tcp"
}

# Egress rule for private RDS which only allows HTTP for package updates
module "private_rds_sg_egress_1" {
  source      = "./modules/security_group_rule"
  sg_source   = false
  type        = "egress"
  sg_id       = module.private_rds_sg.sg_id
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Egress rule for private RDS which only allows HTTPS for package updates
module "private_rds_sg_egress_2" {
  source      = "./modules/security_group_rule"
  sg_source   = false
  type        = "egress"
  sg_id       = module.private_rds_sg.sg_id
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

# Public EC2 instance
module "public_ec2" {
  source    = "./modules/ec2"
  ami       = "ami-0b898040803850657"
  key_name  = "kishan"
  sg_id     = module.public_ec2_sg.sg_id
  subnet_id = module.public_subnet.subnet_id
  tags = merge(
    {
      "Name" = format("%s_public_ec2", var.name)
    },
    var.tags,
  )
}

# Private RDS instance
module "private_rds" {
  source            = "./modules/rds_instance"
  db_name           = "myDB"
  db_username       = "kishandb"
  db_password       = var.db_password # NOTE that password is NOT commited to repo, since the actual tfvars file is gitignored, and an example file is uploaded with no password
  vpc_sg_ids        = [module.private_rds_sg.sg_id]
  subnet_group_name = "kishan_rds_subnet_group"
  subnet_ids        = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  rds_tags = merge(
    {
      "Name"       = format("%s_private_rds", var.name)
      "dependency" = module.gateways.nat_dependency # Create dependency on NAT in case NAT configutation was required for RDS
    },
    var.tags,
  )
  subnet_group_tags = merge(
    {
      "Name" = format("%s_subnet_group", var.name)
    },
    var.tags,
  )
}

# User data file
data "template_file" "user_data" {
  template = "${file("${path.module}/startup.tpl")}"
  vars = {
    db_password = var.db_password
    endpoint    = "${element(split(":", module.private_rds.rds_endpoint), 0)}"
  }
}

# Private EC2 instance
module "private_ec2" {
  source    = "./modules/ec2"
  ami       = "ami-0b898040803850657"
  key_name  = "kishan"
  sg_id     = module.private_ec2_sg.sg_id
  subnet_id = module.private_subnet_1.subnet_id
  tags = merge(
    {
      "Name" = format("%s_private_ec2", var.name)
    },
    var.tags,
  )
  user_data = "${data.template_file.user_data.rendered}"
  # Creates dependency on RDS since the file uses Database endpoint
  # This is why user data doesn't require an infinite loop
}