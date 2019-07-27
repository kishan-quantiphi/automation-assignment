variable "vpc_id" {
  description = "ID of VPC with which internet gateway is associated"
  type        = string
}

variable "igw_tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}

variable "subnet_id" {
  description = "ID of subnet with which NAT gateway is associated"
  type        = string
}

variable "allocation_id" {
  description = "Allocation ID of Elastic IP which NAT gateway is associated"
  type        = string
}

variable "nat_tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}