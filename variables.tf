# ------------------------------------------------------------------------
# Amazon ECR Repository variables
# ------------------------------------------------------------------------
variable "name" {
  description = "repo name"
  type        = string
}

variable "scan_on_push" {
  description = "Wheter scan on push should be enabled"
  default     = true
  type        = bool
}

variable "image_tag_mutability" {
  description = "Use \"IMMUTABLE\" to prevent image tags from being overwritten by subsequent image pushes using the same tag. Use \"MUTABLE\" to allow image tags to be overwritten."
  default     = "MUTABLE"
  type        = string
}

variable "allowed_account_ids" {
  description = "Allowed account ids to push into this repository"
  default     = []
  type        =  list(string)
}


variable "lifecycle_policy" {
  description = "Lifecycle policy for this repository"
  default     = null
}

variable "kms_key_arn" {
  description = "ARN of the KMS key to be used for encryption."
  default     = null
  type        = string
}

variable "max_image_count" {
  description = "Set a limit on the number of images that exist in the repository."
  default     = 30
  type        = number
}

variable "tags" {
  type        = map(any)
  default     = null
  description = "Map of tags to assign to the resource. "
}
