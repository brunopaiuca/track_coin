variable "topic_arn" {}
variable "protocol" {}

variable "subscriptions" {
  type = "list"
}

variable "customer_role_arn" {
  default = ""
}
