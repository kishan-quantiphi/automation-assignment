variable "sg_source" {
  description = "True if rule uses security group and not cidr block"
  type        = bool
  default     = false
}

variable "sg_id" {
  description = "ID of security group in which rule is to be added"
  type        = string
}

variable "type" {
  description = "ID of security group in which rule is to be added"
  type        = string
}

variable "source_sg_id" {
  description = "ID of source security group"
  type        = string
  default     = ""
}

variable "cidr_blocks" {
  description = "List of source CIDR blocks"
  type        = list(string)
  default     = []
}

variable "from_port" {
  description = "Start port"
  type        = number
}

variable "to_port" {
  description = "End port"
  type        = number
}

variable "protocol" {
  description = "Protocol used"
  type        = string
}

