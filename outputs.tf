output "bucket" {
  description = "R2 bucket resource."
  value = {
    id            = cloudflare_r2_bucket.this.id
    name          = cloudflare_r2_bucket.this.name
    location      = cloudflare_r2_bucket.this.location
    storage_class = cloudflare_r2_bucket.this.storage_class
    creation_date = cloudflare_r2_bucket.this.creation_date
    jurisdiction  = cloudflare_r2_bucket.this.jurisdiction
  }
}

output "cors" {
  description = "R2 bucket CORS configuration."
  value       = try(cloudflare_r2_bucket_cors.this[0], null)
}

output "bucket_lifecycle" {
  description = "R2 bucket lifecycle configuration."
  value       = try(cloudflare_r2_bucket_lifecycle.this[0], null)
}

output "lock" {
  description = "R2 bucket lock configuration."
  value       = try(cloudflare_r2_bucket_lock.this[0], null)
}

output "sippy" {
  description = "R2 bucket Sippy configuration."
  value       = try(cloudflare_r2_bucket_sippy.this[0], null)
  sensitive   = true
}

output "managed_domain" {
  description = "Managed r2.dev domain configuration."
  value       = try(cloudflare_r2_managed_domain.this[0], null)
}

output "custom_domains" {
  description = "Custom domains attached to the bucket."
  value = {
    for k, v in cloudflare_r2_custom_domain.this : k => {
      domain    = v.domain
      enabled   = v.enabled
      zone_id   = v.zone_id
      zone_name = try(v.zone_name, null)
      min_tls   = try(v.min_tls, null)
      ciphers   = try(v.ciphers, null)
      status    = try(v.status, null)
    }
  }
}

output "event_notifications" {
  description = "R2 bucket event notifications."
  value = {
    for k, v in cloudflare_r2_bucket_event_notification.this : k => {
      queue_id   = v.queue_id
      queue_name = try(v.queue_name, null)
      rules      = v.rules
    }
  }
}
