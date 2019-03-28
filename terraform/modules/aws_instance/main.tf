resource "aws_instance" "app" {
  count                = "${var.count}"
  ami                  = "${var.ami}"
  instance_type        = "${var.instance_type}"
  tags                 = "${var.tags}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "bruno-virginia"
  provider             = "aws.app"
}
