output "email_lambda_arn" {
  value = aws_lambda_function.email_lambda.arn
}

output "sms_lambda_arn" {
  value = aws_lambda_function.sms_lambda.arn
}

output "api_handler_lambda_arn" {
  value = aws_lambda_function.api_handler_lambda.invoke_arn
}
