resource "aws_subnet" "this" {
  vpc_id                          = var.vpc_id
  cidr_block                      = var.cidr
  availability_zone_id            = var.az_id
  map_public_ip_on_launch         = var.map_pub_ip
  assign_ipv6_address_on_creation = var.ipv6_on_creation
  tags                            = var.tags
}


