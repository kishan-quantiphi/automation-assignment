resource "aws_security_group_rule" "sg_source" {
  count                    = var.sg_source ? 1 : 0
  security_group_id        = var.sg_id
  type                     = var.type
  source_security_group_id = var.source_sg_id
  from_port                = var.from_port
  to_port                  = var.to_port
  protocol                 = var.protocol
}

resource "aws_security_group_rule" "cidr_source" {
  count             = var.sg_source ? 0 : 1
  security_group_id = var.sg_id
  type              = var.type
  cidr_blocks       = var.cidr_blocks
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.protocol
}