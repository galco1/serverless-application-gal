resource "aws_lambda_function" "email_lambda" {
  filename         = "email_lambda_function.zip"
  function_name    = "email"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "email_reminder.lambda_handler"
  source_code_hash = data.archive_file.email_lambda_zip.output_base64sha256
  runtime          = "python3.8"
}

data "archive_file" "email_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_code_source/email_reminder.py"
  output_path = "email_lambda_function.zip"
}

resource "aws_lambda_function" "sms_lambda" {
  filename         = "sms_lambda_function.zip"
  function_name    = "sms"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "sms_reminder.lambda_handler"
  source_code_hash = data.archive_file.sms_lambda_zip.output_base64sha256
  runtime          = "python3.8"
}

data "archive_file" "sms_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_code_source/sms_reminder.py"
  output_path = "sms_lambda_function.zip"
}

resource "aws_lambda_function" "api_handler_lambda" {
  filename         = "api_handler_lambda_function.zip"
  function_name    = "api_handler"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "api_handler.lambda_handler"
  source_code_hash = data.archive_file.api_handler_lambda_zip.output_base64sha256
  runtime          = "python3.8"
}

data "archive_file" "api_handler_lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_code_source/api_handler.py"
  output_path = "api_handler_lambda_function.zip"
}

 