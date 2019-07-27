variable "vpc_id" {
  description = "ID of VPC with which subnet is associated"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "az_id" {
  description = "ID of availability zone in which subnet will be created"
  type        = string
}

variable "map_pub_ip" {
  description = "Map public IP on launch to instances launched in subnet"
  type        = bool
  default     = true
}

variable "ipv6_on_creation" {
  description = "Map public IPv6 addresses on launch to instances launched in subnet"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add"
  type        = map(string)
  default     = {}
}