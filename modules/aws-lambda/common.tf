resource "aws_iam_role" "iam_for_lambda" {
  name = "LambdaRuntimeRole"

  inline_policy {
    name = "root"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:*:*:*",
          "Effect" : "Allow"
        },
        {
          "Action" : [
            "ses:*",
            "states:*",
            "sns:*"
          ],
          "Resource" : "*",
          "Effect" : "Allow"
        }
      ]
    })
  }

  assume_role_policy = <<EOF
{
          "Version": "2012-10-17",
          "Statement": [
            {
              "Action": "sts:AssumeRole",
              "Principal": {
                "Service": "lambda.amazonaws.com"
              },
              "Effect": "Allow",
              "Sid": ""
            }
          ]
        }
EOF
}


