output "role-name" {
  value = "bastion-${var.region}"
}

output "instance-profile-name" {
  value = aws_iam_instance_profile.bastion_profile.name
}