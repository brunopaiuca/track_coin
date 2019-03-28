provider "aws" {
  assume_role {
    role_arn = "${var.customer_role_arn}"
  }

  alias = "track_coin"
}
