# Terraform Beginner Bootcamp 2023

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