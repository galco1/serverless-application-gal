provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "lambda" {
  source = "./modules/aws-lambda"

  SFN_ARN = module.step_function.SFN_ARN
}

module "step_function" {
  source = "./modules/aws-step-function"

  email_lambda_arn = module.lambda.email_lambda_arn
  sms_lambda_arn   = module.lambda.sms_lambda_arn
}

module "api_gateway" {
  source = "./modules/aws-api-gateway"

  api_handler_lambda_arn = module.lambda.api_handler_lambda_arn
}

module "s3" {
  source = "./modules/aws-s3"

  api_endpoint = module.api_gateway.invoke_url
}
