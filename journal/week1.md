# Terraform Beginner Bootcamp 2023 - week 1


## Fixing tags

[How to delete local and remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locally delete a tag
```sh
$ git tag -d <tag_name>
```

Remotely delete a tag
```sh
$ git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your git hub history.

```
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```
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
## Terraform Locals

Locals allow us to define local variables .
It can be very useful when we need to transform data in to another format and have references as a variable.
[Locals values](https://developer.hashicorp.com/terraform/language/values/locals)
```tf
locals {
  service_name = "forum"
  owner        = "Community Team"
}
```
## Terraform Data Sources
This allows us to source data from cloud resources

this is useful when we want to reference could resoucres without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```


[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with Json

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of resources

[Meta arguments Life cycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data 

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

```tf
resource "terraform_data" "replacement" {
  input = var.revision
}
```
[The terraform_data Managed Resource Type](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners 

Provisioners allow you to execute commands on compute instances e.g . a AWS CLI command

They are not recommended for use by Hashicorp becoz configuration management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners are a Last Resort](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute a command on the machine running the terraform commands. eg. Plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}

```

[local-exec Provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)
### Remote-exec

This will execute commands on a machine which you target, You will need to provide cred such as ssh to get in to the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}

```

[remote-exec Provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)

## Setup Http-server npm

Updates in Gitpod.yml
```tf
- name: http-server
    before: |
      npm install --global http-server
    command : 
     http-server
```

```tf
http-server: a simple static HTTP server
```
[http-server: a simple static HTTP server](https://www.npmjs.com/package/http-server)
## For each expreassions

For each allows us to enumerate over complex data types 
```tf
[for s in var.list : upper(s)]

```
This is mostly usefull when you are creating multiple resources, and you want to reduce the amt of repetetive terraform code.
[for each Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)
