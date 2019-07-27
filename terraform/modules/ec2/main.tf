resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]
  tags                   = var.tags
  volume_tags            = var.volume_tags
  user_data              = var.user_data
}


