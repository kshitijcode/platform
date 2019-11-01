data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = [
      "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "bastion-policy" {
  name = "bastion-policy-${var.region}"
  description = "Policy for Bastion Hosts"
  policy = file("${path.module}/../../data/bastion-iam-policy.json")

}


module "role" {
  source = "../../modules/iam-role"
  role-name = "bastion-${var.region}"
  description = "IAM role with permissions to connect to Bless Lambda for certificates"
  assume-role-policy = data.aws_iam_policy_document.instance-assume-role-policy.json
  policies = [
    aws_iam_policy.bastion-policy.arn]
}

// Creating IAM Bastion Profile
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion-host"
  role = module.role.role-name
}

