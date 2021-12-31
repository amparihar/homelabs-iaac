
resource "kubernetes_namespace" "aws_observability" {
  metadata {
    name = "aws-observability"
    labels = {
      "aws-observability" = "enabled"
    }
  }
}

resource "kubernetes_config_map" "aws_logging" {
  metadata {
    name      = "aws-logging"
    namespace = kubernetes_namespace.aws_observability.id
  }
  data = {
    "output.conf" = "[OUTPUT]\n    Name cloudwatch_logs\n    Match   *\n    region ${var.region_id}\n    log_group_name /aws/eks/${var.cluster_name}/fluent-bit-cloudwatch\n    log_stream_prefix from-fluent-bit-\n    auto_create_group true\n"
  }
}