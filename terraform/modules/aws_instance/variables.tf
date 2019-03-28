variable "count" {}
variable "ami" {}
variable "instance_type" {}

variable "tags" {
  type = "map"
}

variable "iam_instance_profile" {}

variable "customer_role_arn" {
  default = ""
}
