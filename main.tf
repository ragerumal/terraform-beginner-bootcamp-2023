terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0" 
    }
  }
  # backend "remote" {
  #   hostname = "app.terraform.io"
  #   organization = "TerraformTrainingRaghuerumal"

  #   workspaces {
  #     name = "terra-house-1"
  #   } 

  cloud {
    organization = "TerraformTrainingRaghuerumal"
    workspaces {
      name = "terra-house-1"
    }
  }
  
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
  # endpoint = "https://terratowns.cloud/api"
  # user_uuid="f511f11f-1d11-44ed-8359-db2f89e317e7" 
  # token="e2868a92-5a0b-402b-b1f7-ef58d0a799ea"
}
module "home_arcanum_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid= var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  public_path = var.arcanum.public_path
  content_version=var.arcanum.content_version
}

resource "terratowns_home" "home_arcanum" {
  name = "How to play Arcanum in 2023!"
  description = <<DESCRIPTION
Arcanum is a game from 2001 that shipped with alot of bugs.
Modders have removed all the originals making this game really fun
to play (despite that old look graphics). This is my guide that will
show you how to play arcanum without spoiling the plot.
DESCRIPTION
  domain_name = module.home_arcanum_hosting.cloudfront_url
  #domain_name = "3ddeedg.cloudfront.net"
  town = "missingo"
  content_version = var.arcanum.content_version
}

module "home_biryani_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid= var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  public_path = var.biryani.public_path
  content_version=var.biryani.content_version
}
resource "terratowns_home" "home_biryani" {
  name = "Recipe for Biryani"
  description = <<DESCRIPTION
Since i like biryani so much , so i decided to put on this recipe to the world.
DESCRIPTION
  domain_name = module.home_biryani_hosting.cloudfront_url
  #domain_name = "3ddeedg.cloudfront.net"
  town = "missingo"
  content_version = var.biryani.content_version
}

