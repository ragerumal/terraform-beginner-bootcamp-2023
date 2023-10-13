variable "user_uuid" {
  description = "User UUID"
  type        = string
  validation {
    condition     = can(regex("^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$", var.user_uuid))
    error_message = "Invalid User UUID format. It should be in the form of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)."
  }
}

# variable "bucket_name" {
#   description = "AWS S3 Bucket Name"
#   type        = string
#   validation {
#     condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
#     error_message = "Invalid S3 bucket name. It should be between 3 and 63 characters long and only contain lowercase letters, numbers, hyphens, and periods."
#   }
# }

variable "public_path" {
  description = "the file path to public directory"
  type        = string

  
}



variable "content_version" {
  description = "Content version (positive integer starting from 1)"
  type        = number

  validation {
    condition     = var.content_version >= 1 && floor(var.content_version) == var.content_version
    error_message = "Content version must be a positive integer starting from 1."
  }
}
