output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

output "route_table_ids" {
  description = "List of Route Table IDs"
  value = module.vpc.intra_route_table_ids
}