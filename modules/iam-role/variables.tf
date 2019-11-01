variable "policies" {
  description = "IAM Policy to be attached to role"
  type = "list"
  default = []
}

variable "role-name" {
  description = "IAM Role name to be attached to Policy"
  type = "string"
}

variable "assume-role-policy" {
  description = "Assume Role Policy for IAM Role"
  type = "string"
}

variable "description" {
  description = "Description of IAM Role"
  type = "string"
}
