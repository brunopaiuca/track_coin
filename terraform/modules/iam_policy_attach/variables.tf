variable "name" {}

variable "roles" {
  type = "list"
}

variable "policy_arn" {}

variable "customer_role_arn" {
  default = ""
}
