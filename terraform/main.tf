data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "${ format("%s-*", var.project)}"
  owners      = ["self"]
  provider    = "aws.track_coin"
}

locals {
  common_tags = {
    environment   = "${var.environment}"
    service       = "${var.project}"
    ProvisionedBy = "Terraform"
  }
}

module "sns_topic" {
  source            = "./modules/sns_topic"
  topic_name        = "${ format("%s%s", var.environment, var.project) }"
  provider          = "aws.track_coin"
  customer_role_arn = "${var.customer_role_arn}"
}

module "topic_subscription" {
  source    = "./modules/subscription"
  topic_arn = "${module.sns_topic.arn}"
  protocol  = "sms"

  subscriptions = [
    "+5511982618755"
  ]
  customer_role_arn = "${var.customer_role_arn}"
}


module "parameter_sns_topic_endpoint" {
  source = "./modules/ssm_parameter"
  name   = "${format("%s_topic_endpoint", var.project)}"
  type   = "String"
  value  = "${module.sns_topic.arn}"
  customer_role_arn = "${var.customer_role_arn}"
}

module "parameter_env" {
  source = "./modules/ssm_parameter"
  name   = "${format("%s_env", var.project)}"
  type   = "String"
  value  = "${var.environment}"
  customer_role_arn = "${var.customer_role_arn}"
}


module "app-instances" {
  source               = "./modules/aws_instance"
  count                = 1
  ami                  = "${data.aws_ami.ami.id}"
  instance_type        = "t3.micro"
  iam_instance_profile = "${module.iam_instance_profile.id}"
  tags                 = "${local.common_tags}"
  customer_role_arn = "${var.customer_role_arn}"
}
