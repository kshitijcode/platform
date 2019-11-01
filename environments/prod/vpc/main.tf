module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "platform-vpc"
  cidr = "10.90.0.0/18"

  azs = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"]
  private_subnets = [
    "10.90.0.0/22",
    "10.90.4.0/22",
    "10.90.8.0/22"]
  public_subnets = [
    "10.90.12.0/22",
    "10.90.16.0/22",
    "10.90.20.0/22"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "platform-tooling"
  }
}

data "aws_route_tables" "routetables" {

  vpc_id = module.vpc.vpc_id

}

resource "aws_route" "vpc_peering_route" {
  count = length(data.aws_route_tables.routetables.ids)
  route_table_id = tolist(data.aws_route_tables.routetables.ids)[count.index]
  destination_cidr_block = "10.41.0.0/16"
  vpc_peering_connection_id = var.pcx-atv-staging
}

