locals {
  api_integrations = {
    for api_endpoint, lambda in var.api_integrations :
    api_endpoint => {
      payload_format_version = "2.0"
      lambda_arn             = "arn:aws:lambda:${data.aws_region.region.name}:${data.aws_caller_identity.identity.account_id}:function:${lambda}"
    }
  }
}

module "api_gateway" {
  source                                   = "terraform-aws-modules/apigateway-v2/aws"
  name                                     = var.api_name
  integrations                             = local.api_integrations
  create_api_domain_name                   = false
  default_stage_access_log_destination_arn = module.logs.log_group_arn
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"
}
