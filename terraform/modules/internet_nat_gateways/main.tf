resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
  tags   = var.igw_tags
}

resource "aws_nat_gateway" "this" {
  allocation_id = var.allocation_id
  subnet_id     = var.subnet_id
  tags          = var.nat_tags
  depends_on    = ["aws_internet_gateway.this"]
}

resource "null_resource" "dummy_dependency" {
  depends_on = ["aws_nat_gateway.this"]
}

