#!/usr/bin/env bash

# Set the target directory
target_dir="/home/gitpod/.terraform.d"

# Create the target directory if it doesn't exist
if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir"
fi

# Check if the TERRAFORM_CLOUD_TOKEN environment variable is set
if [ -z "$TERRAFORM_CLOUD_TOKEN" ]; then
    echo "Error: TERRAFORM_CLOUD_TOKEN environment variable is not set."
    exit 1
fi

# Define the JSON structure
json_data='{
  "credentials": {
    "app.terraform.io": {
      "token": "'"$TERRAFORM_CLOUD_TOKEN"'"
    }
  }
}'

# Write the JSON data to credentials.tfrc.json in the target directory
echo "$json_data" > "$target_dir/credentials.tfrc.json"

echo "credentials.tfrc.json file has been created in $target_dir with your Terraform Cloud token."

