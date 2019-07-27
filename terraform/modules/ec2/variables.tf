variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "sg_id" {
  description = "Security group ID to associate with"
  type        = string
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  type        = map(string)
  default     = {}
}

