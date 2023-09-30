terraform {
  # backend "remote" {
  #   hostname = "app.terraform.io"
  #   organization = "TerraformTrainingRaghuerumal"

  #   workspaces {
  #     name = "terra-house-1"
  #   } 

#   cloud {
#     organization = "TerraformTrainingRaghuerumal"
#     workspaces {
#       name = "terra-house-1"
#     }
#   }
  
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid= var.user_uuid
  bucket_name = var.bucket_name
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
  content_version=var.content_version
}




