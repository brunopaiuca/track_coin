resource "aws_sns_topic_subscription" "topic_subscription" {
  count     = "${length("${var.subscriptions}")}"
  topic_arn = "${var.topic_arn}"
  protocol  = "${var.protocol}"
  endpoint  = "${element("${var.subscriptions}", count.index)}"
  provider  = "aws.app"
}
