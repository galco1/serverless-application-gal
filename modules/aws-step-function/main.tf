resource "aws_sfn_state_machine" "sfn_state_machine" {
  name       = "MyStateMachine"
  role_arn   = aws_iam_role.step_function_role.arn
  definition = data.template_file.sfn-definition.rendered
  type       = "STANDARD"
  tracing_configuration {
    enabled = false
  }
}

data "template_file" "sfn-definition" {
  template = "${file("${path.module}/step_function_template.json")}"
  vars = {
    email_reminder_arn = var.email_lambda_arn
    text_reminder_arn  = var.sms_lambda_arn
  }
}
