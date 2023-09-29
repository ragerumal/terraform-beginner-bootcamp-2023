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

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
    etag = "${md5(file("${path.root}/public/index.html"))}"
  #etag = filemd5("path/to/file")
}