variable "api_name" {}

variable "api_integrations" {
  type        = any
  description = "API to Lambda mappings. (See examples.)"
}

variable "lambda_functions" {
  type        = any
  description = "Lambda functions. (See examples.)"
}
