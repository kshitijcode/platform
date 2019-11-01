variable "subnets" {
  default = [
    "subnet-01d117349b5d79456",
    "subnet-04135e26fb7afef92",
    "subnet-0a684a09685013eda"]
}

variable ami_id {
  default = "ami-0123b531fc646552f"
}

variable security_group {
  default = "sg-430e1921"
}

variable key_name {
  default = "ops"
}

variable instance_type {
  default = "t3.small"
}

variable vpc_id {
}

variable "region" {
  default = "ap-south-1"
}

variable "instance_count" {
  default = "3"
}

