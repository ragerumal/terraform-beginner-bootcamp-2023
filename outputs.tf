output "bucket_name" {
    description = "bucket name for our static website"
    value = module.terrahouse_aws.bucket_name
 }
 output "s3_website_endpoint" {
    description = "S3 static website hosting endpoint"
    value = module.terrahouse_aws.website_endpoint
 }

 locals {
   root_path=path.root
 }
 output "root_path" {
   value = local.root_path
 }