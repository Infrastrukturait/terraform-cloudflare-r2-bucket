variable "account_id" {
  description = "Cloudflare account ID."
  type        = string
}

variable "name" {
  description = "R2 bucket name."
  type        = string
}

variable "location" {
  description = "Optional R2 bucket location."
  type        = string
  default     = null
}

variable "storage_class" {
  description = "Optional default storage class for newly uploaded objects."
  type        = string
  default     = null

  validation {
    condition = var.storage_class == null || contains([
      "Standard",
      "InfrequentAccess"
    ], var.storage_class)
    error_message = "storage_class must be null, Standard, or InfrequentAccess."
  }
}

variable "cors" {
  description = "Optional R2 bucket CORS configuration."
  type = object({
    rules = optional(list(object({
      allowed = object({
        methods = list(string)
        origins = list(string)
        headers = optional(list(string))
      })
      id              = optional(string)
      expose_headers  = optional(list(string))
      max_age_seconds = optional(number)
    })), [])
  })
  default = null
}

variable "bucket_lifecycle" {
  description = "Optional R2 bucket lifecycle configuration."
  type = object({
    rules = optional(list(object({
      id = string
      conditions = optional(object({
        prefix = string
      }))
      enabled = bool

      abort_multipart_uploads_transition = optional(object({
        condition = optional(object({
          max_age = number
          type    = string
        }))
      }))

      delete_objects_transition = optional(object({
        condition = optional(object({
          max_age = optional(number)
          type    = string
          date    = optional(string)
        }))
      }))

      storage_class_transitions = optional(list(object({
        condition = object({
          max_age = optional(number)
          type    = string
          date    = optional(string)
        })
        storage_class = string
      })), [])
    })), [])
  })
  default = null
}

variable "lock" {
  description = "Optional R2 bucket object lock configuration."
  type = object({
    rules = optional(list(object({
      id = string
      condition = object({
        max_age_seconds = optional(number)
        type            = string
        date            = optional(string)
      })
      enabled = bool
      prefix  = optional(string)
    })), [])
  })
  default = null
}

variable "sippy" {
  description = "Optional R2 bucket Sippy configuration."
  type = object({
    source = optional(object({
      access_key_id            = optional(string)
      bucket                   = optional(string)
      r2_bucket_sippy_provider = optional(string)
      region                   = optional(string)
      secret_access_key        = optional(string)
      client_email             = optional(string)
      private_key              = optional(string)
      bucket_url               = optional(string)
    }))
    destination = optional(object({
      access_key_id            = optional(string)
      r2_bucket_sippy_provider = optional(string)
      secret_access_key        = optional(string)
    }))
  })
  default   = null
  sensitive = true
}

variable "managed_domain" {
  description = "Optional managed r2.dev domain configuration."
  type = object({
    enabled = bool
  })
  default = null
}

variable "custom_domains" {
  description = "Optional map of custom domains attached to the bucket."
  type = map(object({
    domain  = string
    zone_id = string
    enabled = bool
    min_tls = optional(string)
    ciphers = optional(list(string))
  }))
  default = {}
}

variable "event_notifications" {
  description = "Optional map of R2 bucket event notifications."
  type = map(object({
    queue_id = string
    rules = list(object({
      actions     = list(string)
      description = optional(string)
      prefix      = optional(string)
      suffix      = optional(string)
    }))
  }))
  default = {}
}
