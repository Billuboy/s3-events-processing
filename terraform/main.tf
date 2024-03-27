# Configuration for AWS provider.
provider "aws" {
  region = "ap-south-1"

  default_tags {
    tags = {
      "provisioned_through" = "terraform"
    }
  }
}

provider "random" {}

resource "random_id" "bucket-prefix" {
  byte_length = 8
}

# Modules

# 1. API Gateway Module
module "s3" {
  source = "./modules/s3"

  bucket_name       = "${var.bucket_name}-${random_id.bucket-prefix.hex}"
  s3_lambda_arn     = module.lambda.s3_lambda_arn
  s3_trigger_suffix = var.s3_trigger_suffix
}

# 2. Lambda Module
module "lambda" {
  source = "./modules/lambda"

  lambda_name       = var.lambda_name
  enable_versioning = var.enable_versioning
  s3_bucket_arn     = module.s3.s3_bucket_arn
}