variable "cloudflare_account_id" {
  description = "Cloudflare account ID used to create and manage the R2 bucket."
  type        = string
}

variable "zone_id" {
  description = "Cloudflare zone ID for the custom domain attached to the R2 bucket."
  type        = string
  default     = null
}

variable "queue_id" {
  description = "Cloudflare Queue ID used by the R2 bucket event notification."
  type        = string
  default     = null
}

variable "enable_managed_domain" {
  description = "Enable the managed R2.dev domain in this example."
  type        = bool
  default     = true
}

variable "custom_domain" {
  description = "Optional custom domain name for the R2 bucket."
  type        = string
  default     = null
}
