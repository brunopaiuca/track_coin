resource "aws_iam_policy_attachment" "iam_policy_attach" {
  name       = "${var.name}"
  roles      = ["${var.roles}"]
  policy_arn = "${var.policy_arn}"
  provider   = "aws.app"
}
