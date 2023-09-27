variable "user_uuid" {
  description = "User UUID"
  type        = string
  validation {
    condition     = can(regex("^([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})$", var.user_uuid))
    error_message = "Invalid User UUID format. It should be in the form of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)."
  }
}