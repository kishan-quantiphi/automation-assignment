variable "vpc_id" {
  description = "ID of VPC with which route table is associated"
  type        = string
}

variable "igw_source" {
  description = "If True source is an Internet Gateway, otherwise it is a NAT Gateway"
  type        = bool
  default     = true
}

variable "igw_id" {
  description = "The ID of the Internet Gateway"
  type        = string
  default     = ""
}

variable "nat_id" {
  description = "The ID of the NAT Gateway"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}