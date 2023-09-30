# Terraform Beginner Bootcamp 2023 - week 1

## Root module Structure

our root module structure is as follows :

```
PROJECT_ROOT
├── main.tf              # everything else
├── variables.tf         # stores the structure of input variables
├── providers.tf         # defined required providers and their configuration
├── outputs.tf           # stores our output
├── terraform.tfvars     # the data of variables we want to load into our Terraform project
└── README.md            # required for root modules
```
  
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terraform and Input varaibles

[Terraform input variables](https://developer.hashicorp.com/terraform/language/values/variables)

## Terraform Cloud variables

In Terraform we can set two kind of variables :

- Environment Variables - those set in your bash terminal e.g: AWS credentials
- Terraform variables - those that you would normaly set in your tfvars file

We can set Terraform clound variables to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input variables 

### var flag
We can use the `var` flag to set an input variable or overide a variable in the tfvars file eg. `terrafrom -var user_uuid="my-user_id"`

### var-file flag

 - TODO : research this flag

 ### terraform.rvtfbars

 This is the default file to load in terraform variables in blank

 ### auto.tfvars

 - TODO: document this functionallity for terraform cloud 

 ### order of terraform variables

 - TODO : document which terraform variables takes precedence.


 ### Dealing with configuration Drift
 
 ## What happens if we loose our State file ?

 If you loose your state file, you most likey have to tear down all your cloud infra manually. You can use terraform port but it wont for all cloud resources. you need to check the terraform providers documentation for which resources support import.
 

 ## Fix missing Resources wuth Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/language/import)

[AWS S3 Bucket import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)


### Fix manual Configuration

If someone goes and delete or modifies cloud resource manually Clickops.

If we run Terrform Plan is with attempt to put our Infrastructre back in to the expected state fixing Configuration Drift.

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules 

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when developing modules but you can name it what ever you like.

### Passing input variables

We can pass input variables to our modules

The module has to declare the terraform variables in its own variables.tf 

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid= var.user_uuid
  bucket_name = var.bucket_name
}
```

### Module sources 

Using the source we can import the module from various places 
- Locally
- Github 
- Terraform Registroy 


```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid= var.user_uuid
  bucket_name = var.bucket_name
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)


## Considerations when using ChatGPT to write terraform 

LLMs such as ChatGPT may not be trained on the latest documentation or info abt terraform

It may likely produce older examples that could be depracated. often affecting providers.

## Working with Files in Terraform

### Filesexists function

This is a built in terraform function to check the existence of a file.
https://developer.hashicorp.com/terraform/language/functions/file
```tf
validation {
    condition     = can(file(var.error_html_filepath))
    error_message = "The specified error_html_filepath does not exist or is invalid."
  }
```

### Filemd5 
### path variable 

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for current module
- path.root = get path for the root module 
[Special path variable](https://developer.hashicorp.com/terraform/language/expressions/references)


```sh
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

}
```
