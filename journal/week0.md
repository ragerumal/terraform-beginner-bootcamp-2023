# Terraform Beginner Bootcamp 2023 - week 0

- [Semantic Versioning :mage:](#semantic-versioning--mage-)
  * [Refactoring in to bash scripts](#refactoring-in-to-bash-scripts)
  * [Working with Env var](#working-with-env-var)
  * [env cmd](#env-cmd)
  * [Setting and unsetting env vars](#setting-and-unsetting-env-vars)
    + [Printing env vars](#printing-env-vars)
    + [Scoping of Env Vars](#scoping-of-env-vars)
    + [Persisting env vars in Gitpod](#persisting-env-vars-in-gitpod)
  * [AWS CLI Installation](#aws-cli-installation)
  * [Terrform Basics](#terrform-basics)
- [Terraform registry](#terraform-registry)
- [Terraform init](#terraform-init)
- [Terraform Plan](#terraform-plan)
- [Terraform apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
- [Issues with terraform Cloud login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Semantic Versioning :mage:
This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general Fortmat : 

**MAJOR.MINOR.PATCH**, eg. `1.0.1`
- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

##Install the terraform CLI

##Reference:

[Install Teraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-cli)

### Refactoring in to bash scripts 

While fixing the terraform CLI gpg depreciation  issues , we notice  that bash scripts were more considerbale amout of code .

### Working with Env var

### env cmd
we can list all env variables using the env command 

we can filter specific env var using grep e.g `env | grep AWS`

### Setting and unsetting env vars

In the terminal we can set using `export HELLO='world`

In the terminal we unset using `unset HELLO`

we can set env var temporarily when just running a command 

```sh
$HELLO=`world` ./bin/print_message
```
within a bash script we cans et env var without writing export e.g

```sh
#!/usr/bin/env bash

HELLO=`world`

echo $HELLO
```

#### Printing env vars

We can print env var using echo eg `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminal in VS code  it will not be aware of env vars that you have set in another window.

if you want env vars to persist in all furture terminals, you need to set env var in your bash profiles. eg: `.bash_profile`

#### Persisting env vars in Gitpod 

We can persist env vars in to git pod by storing them in Git pod secret storage 

```
gp env HELLO=`world`
```

All future workspaces launched will set the env vars for all bash terminals, opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can onluy contain non-sensitve env vars.


### AWS CLI Installation 

AWS CLI is installed for the project.

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli.sh)

[Getting Started Install ( AWS CLI ) ](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our credentials are confugured correctly by running the following aws command
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload look like this

```json
{
    "UserId": "AIBAVCAEU4FCMZEBLDF7R",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentails from IAM user in order to use in AWS Cli.

### Terrform Basics
These are some fundamental Terraform concepts and commands to get you started with infrastructure as code. Terraform offers many more features and capabilities for managing complex infrastructures, and you can explore the documentation for more in-depth information.

## Terraform registry
Terraform Registry
The Terraform Registry is a repository of pre-built, community-contributed Terraform modules and configurations. It allows you to reuse and share infrastructure code to speed up your development process. You can find modules for various cloud providers and services on the Terraform Registry.




## Terraform init
Terraform Init
The terraform init command initializes a Terraform working directory. It performs the following tasks:

Downloads and installs the required provider plugins specified in your configuration.
Initializes a .terraform directory to store plugins and other internal files.
Downloads the necessary module dependencies if you are using modules from the Terraform Registry.
You typically run terraform init once in your project directory after setting up your Terraform configuration or when adding new providers or modules to your configuration.

## Terraform Plan
Terraform Plan
The terraform plan command is used to create an execution plan. It examines your Terraform configuration and shows you what actions Terraform will take to create, update, or delete resources based on your configuration changes. This is a crucial step before applying changes to your infrastructure.

When you run terraform plan, Terraform will not make any changes to your infrastructure; it only generates a plan for review. This allows you to verify that your intended changes align with your expectations.
## Terraform apply
Terraform Apply
The terraform apply command is used to apply the changes defined in your Terraform configuration to your infrastructure. It executes the plan generated by terraform plan. When you run terraform apply, Terraform will create, update, or delete resources as needed based on the plan.

Be cautious when running terraform apply in a production environment, as it can make significant changes to your infrastructure. Always review the plan generated by terraform plan before applying changes to ensure they match your intentions.

#### Terraform Destroy

This will destroy resources 

you can also use the -auto-approve 

## Issues with terraform Cloud login and Gitpod Workspace

When attempting to run `terrform login` it will launch bash a wiswig view to generat a token.
However it does not work as expected in Gitpod VsCode in the browser.

The workaround is to manually generate a token .
After creating a file manually .
And open the file 


```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json

```
```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "F2aaIh5eOhAYcc.atlasv1.7775NOPEzo82qN88elI0qgbcyu3Jr0N4rluUqzIHEgsNf5uRxPfJ7DiV3QzwEXoNOPE"
    }
  }
}
```

We have Automated the workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)
