output "arn" {
  value = "${aws_sns_topic.notification_topic.arn}"
}
