resource "aws_security_group" "bastion" {
  name = "bastion"
  description = "Security Group for Bastion Hosts"
  vpc_id = var.vpc_id

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port = 22
    protocol = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = [
      "10.41.0.0/16",
      "10.90.0.0/18"
    ]
  }

  tags = {
    Terraform = "true"
  }
}


// IAM dependencies for our bastion
module "iam" {
  source = "../../global/iam"
}

module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"
  instance_count = var.instance_count
  instance_type = var.instance_type
  ami = var.ami_id
  iam_instance_profile = module.iam.instance-profile-name
  key_name = var.key_name
  subnet_ids = var.subnets
  vpc_security_group_ids = [
    aws_security_group.bastion.id]
  name = "bastion-host"
  tags = {
    terraform = "true"
    environment = "dev"
    role = "bastion"
    platform = "infrastructure"
  }
}