resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  tags       = var.subnet_group_tags
}

resource "aws_db_instance" "this" {
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = var.vpc_sg_ids
  db_subnet_group_name   = aws_db_subnet_group.this.name
  tags                   = var.rds_tags
}
