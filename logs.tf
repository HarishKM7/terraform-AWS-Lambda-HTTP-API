module "logs" {
  source    = "cn-terraform/cloudwatch-logs/aws"
  logs_path = "/aws/api-gateway/${var.api_name}"
}
