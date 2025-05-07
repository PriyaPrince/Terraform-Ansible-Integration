## modules/security_group/variables.tf
variable "security_group_name" {
  description = "securitygroup name"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Allow SSH and HTTP traffic"
}

