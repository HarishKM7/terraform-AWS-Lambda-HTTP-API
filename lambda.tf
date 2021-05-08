module "lambda_function" {
  source                                  = "terraform-aws-modules/lambda/aws"
  for_each                                = var.lambda_functions
  function_name                           = each.key
  runtime                                 = each.value.runtime
  handler                                 = each.value.handler
  create_package                          = false
  local_existing_package                  = each.value.zip
  create_current_version_allowed_triggers = false
  allowed_triggers = {
    api-gateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*/*"
    }
  }
}
