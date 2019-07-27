variable "name" {
  description = "Name of security group"
  type        = string
}

variable "description" {
  description = "Description of security group"
  type        = string
}

variable "vpc_id" {
  type        = "string"
  description = "ID of VPC in which security group is created"
}


variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

# variable "uses_security_group" {
#   description = "True if ingress rule uses security gro"
#   type = bool
#   default = false
# }