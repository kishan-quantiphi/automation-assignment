resource "aws_route_table" "igw_rt" {
  count  = var.igw_source ? 1 : 0
  vpc_id = var.vpc_id
  tags   = var.tags
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

resource "aws_route_table" "nat_rt" {
  count  = var.igw_source ? 0 : 1
  vpc_id = var.vpc_id
  tags   = var.tags
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }
}
