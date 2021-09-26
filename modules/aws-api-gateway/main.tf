resource "aws_api_gateway_rest_api" "reminders"{
   name          = "lambda_gw_api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "reminders" {
  rest_api_id = aws_api_gateway_rest_api.reminders.id
  parent_id = aws_api_gateway_rest_api.reminders.root_resource_id
  path_part = "reminders"
}

resource "aws_api_gateway_method" "post" {
  rest_api_id = aws_api_gateway_rest_api.reminders.id
  resource_id = aws_api_gateway_resource.reminders.id
  http_method = "POST"
  authorization = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.reminders.id
  resource_id = aws_api_gateway_resource.reminders.id
  http_method = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = var.api_handler_lambda_arn
}

resource "aws_api_gateway_deployment" "reminders-deployment" {
rest_api_id = aws_api_gateway_rest_api.reminders.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.reminders.body))
  }

  depends_on = [aws_api_gateway_integration.integration]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "reminders" {
  deployment_id = aws_api_gateway_deployment.reminders-deployment.id
  rest_api_id = aws_api_gateway_rest_api.reminders.id
  stage_name = "prod"
}

