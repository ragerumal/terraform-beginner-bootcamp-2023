terraform {

    required_providers {
  
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}


# provider "aws" {
# #   region     = "us-west-2"
# #   access_key = "my-access-key"
# #   secret_key = "my-secret-key"
# }
resource "aws_s3_bucket" "website_bucket" {
bucket = var.bucket_name
  tags = {
      UserUuid = var.user_uuid
    }
}
