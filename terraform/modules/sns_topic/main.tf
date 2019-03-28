resource "aws_sns_topic" "notification_topic" {
  name     = "${var.topic_name}"
  provider = "aws.app"
}
