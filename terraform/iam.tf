data "aws_caller_identity" "aws_account" {
  provider    = "aws.track_coin"
}

data "aws_region" "region" {
  provider    = "aws.track_coin"
}

data "template_file" "iam_policy_json" {
  template = "${file("policy-stack.tmpl")}"

  vars {
    aws_region     = "${data.aws_region.region.name}"
    aws_account_id = "${data.aws_caller_identity.aws_account.account_id}"
    project        = "${var.project}"
    environment    = "${var.environment}"
  }
}

module "iam_role" {
  source             = "./modules/iam_role"
  name               = "${ format("%s-APP-ROLE", var.project) }"
  assume_role_policy = "${file("assume-role-policy.json")}"
  customer_role_arn = "${var.customer_role_arn}"
}

module "iam_policy" {
  source = "./modules/iam_policy"
  name   = "${ format("%s-APP-IAMROLE", var.project) }"
  policy = "${data.template_file.iam_policy_json.rendered}"
  customer_role_arn = "${var.customer_role_arn}"
}

module "iam_policy_attach" {
  source     = "./modules/iam_policy_attach"
  name       = "${ format("%s-APP-IAMPOLICY-ATTACH", var.project) }"
  roles      = ["${module.iam_role.name}"]
  policy_arn = "${module.iam_policy.arn}"
  customer_role_arn = "${var.customer_role_arn}"
}

module "iam_instance_profile" {
  source = "./modules/iam_instance_profile"
  name   = "${ format("%s-APP-INST-PROFILE", var.project) }"
  role   = "${module.iam_role.name}"
  customer_role_arn = "${var.customer_role_arn}"
}
