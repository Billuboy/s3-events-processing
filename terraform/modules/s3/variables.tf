variable "bucket_name" {
  type = string
}

variable "s3_lambda_arn" {
  type = string
}


variable "s3_trigger_suffix" {
  type = list(string)
}