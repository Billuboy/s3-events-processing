variable "api_env" {
  type        = string
  description = "Please enter environment for APIs"
  default     = "production"
}

variable "bucket_name" {
  type        = string
  description = "Please enter name for the S3 bucket"
  default     = "avatar-bucket"
}

variable "lambda_name" {
  type        = string
  description = "Please enter a name for lambda"
  default     = "s3-events-lambda"
}

variable "enable_versioning" {
  type        = bool
  description = "Do you want to enable versioning for lambda?"
  default     = true
}

variable "s3_trigger_suffix" {
  type        = list(string)
  description = "Please enter value for S3 trigger suffixes"
  default     = [".jpeg", ".jpg", ".png", ".heic"]
}