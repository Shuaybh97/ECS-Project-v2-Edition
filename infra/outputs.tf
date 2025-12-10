output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = module.dynamodb.table_name
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_id
}

output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.alb.load_balancer_dns_name
}

