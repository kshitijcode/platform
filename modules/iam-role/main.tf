resource "aws_iam_role" "default" {
  name = var.role-name
  assume_role_policy = var.assume-role-policy
  description = var.description
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role = aws_iam_role.default.name
  count = length(var.policies)
  policy_arn = var.policies[count.index]
}
