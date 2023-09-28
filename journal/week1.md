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