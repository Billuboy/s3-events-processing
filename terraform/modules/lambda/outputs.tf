# Exporting lambda invoke arn so, that API Gateway can use it for the integration.
output "s3_lambda_arn" {
  value = aws_lambda_function.s3_notification_lambda.arn
}