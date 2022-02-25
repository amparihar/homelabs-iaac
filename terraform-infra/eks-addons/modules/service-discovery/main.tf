resource "random_uuid" "random" {}

resource "aws_service_discovery_private_dns_namespace" "main" {
  count = var.enabled ? 1 : 0
  name  = "${var.app_name}.${var.stage_name}.todos-api.pvt.local"
  vpc   = var.vpc_id
}

# resource "aws_service_discovery_service" "mysql_db_microservice" {
#   count = var.enabled ? 1 : 0
#   name = "database"
#   dns_config {
#     namespace_id = element(aws_service_discovery_private_dns_namespace.main.*.id, count.index)
#     dns_records {
#       ttl  = 300
#       type = "A"
#     }
#     routing_policy = "MULTIVALUE"
#   }
#   health_check_custom_config {
#     failure_threshold = 1
#   }
# }

output "namespace_name" {
  value = var.enabled ? aws_service_discovery_private_dns_namespace.main[0].name : ""
}