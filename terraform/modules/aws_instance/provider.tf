provider "aws" {
  alias = "app"

  assume_role {
    role_arn = "${var.customer_role_arn}"
  }
}
