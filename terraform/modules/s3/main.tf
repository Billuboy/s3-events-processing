resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_notification" "jpeg_notification" {
  bucket = aws_s3_bucket.s3_bucket.id

  dynamic "lambda_function" {
    for_each = var.s3_trigger_suffix
    content {
      filter_suffix       = lambda_function.value
      events              = ["s3:ObjectCreated:*"]
      lambda_function_arn = var.s3_lambda_arn
    }
  }

  # lambda_function {
  # }

  # lambda_function {
  #   events              = ["s3:ObjectCreated:*"]
  #   filter_suffix       = ".jpg"
  #   lambda_function_arn = var.s3_lambda_arn
  # }

  # lambda_function {
  #   events              = ["s3:ObjectCreated:*"]
  #   filter_suffix       = ".png"
  #   lambda_function_arn = var.s3_lambda_arn
  # }

  # lambda_function {
  #   events              = ["s3:ObjectCreated:*"]
  #   filter_suffix       = ".heic"
  #   lambda_function_arn = var.s3_lambda_arn
  # }
}

# resource "aws_s3_bucket_notification" "jpg_notification" {
#   bucket = aws_s3_bucket.s3_bucket.id

# }

# resource "aws_s3_bucket_notification" "png_notification" {
#   bucket = aws_s3_bucket.s3_bucket.id

# }

# resource "aws_s3_bucket_notification" "heic_notification" {
#   bucket = aws_s3_bucket.s3_bucket.id

# }