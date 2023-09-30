variable "user_uuid" {
  description = "User UUID"
  type        = string
  validation {
    condition     = can(regex("^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$", var.user_uuid))
    error_message = "Invalid User UUID format. It should be in the form of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)."
  }
}

variable "bucket_name" {
  description = "AWS S3 Bucket Name"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "Invalid S3 bucket name. It should be between 3 and 63 characters long and only contain lowercase letters, numbers, hyphens, and periods."
  }
}

variable "index_html_filepath" {
  description = "Path to the index.html file"
  type        = string

  validation {
    condition     = can(file(var.index_html_filepath))
    error_message = "The specified index_html_filepath does not exist or is invalid."
  }
}

variable "error_html_filepath" {
  description = "Path to the error.html file"
  type        = string

  validation {
    condition     = can(file(var.error_html_filepath))
    error_message = "The specified error_html_filepath does not exist or is invalid."
  }
}
