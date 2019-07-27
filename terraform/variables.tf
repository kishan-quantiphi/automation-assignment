variable "name" {
  description = "Prefix for Name tag of each resource"
  type        = string
}

variable "tags" {
  description = "A map of tags to add (except for Name)"
  type        = map(string)
  default     = {}
}

variable "db_password" {
  description = "Password for database"
  type        = string
}
