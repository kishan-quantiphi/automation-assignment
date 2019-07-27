variable "subnet_group_name" {
  description = "Name of RDS subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet ids"
  type        = list(string)
}

variable "subnet_group_tags" {
  description = "Tags for RDS subnet group"
  type        = map(string)
  default     = {}
}

variable "allocated_storage" {
  description = "Amount of allocated storage"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Type of storage"
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
  default     = "5.7"
}

variable "instance_class" {
  description = "Database instance class"
  type        = string
  default     = "db.t2.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_password" {
  description = "Password of database master"
  type        = string
}

variable "vpc_sg_ids" {
  description = "List of VPC security groups"
  type        = list(string)
}

variable "rds_tags" {
  description = "Tags for RDS instance"
  type        = map(string)
  default     = {}
}
