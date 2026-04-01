output "bucket_name" {
  description = "Name of the created R2 bucket."
  value       = module.r2_assets.bucket.name
}

output "bucket_location" {
  description = "Location configured for the R2 bucket."
  value       = module.r2_assets.bucket.location
}

output "bucket_storage_class" {
  description = "Default storage class configured for the R2 bucket."
  value       = module.r2_assets.bucket.storage_class
}

output "managed_domain" {
  description = "Managed R2 domain configuration created for the bucket."
  value       = module.r2_assets.managed_domain
}

output "custom_domains" {
  description = "Custom domains attached to the R2 bucket."
  value       = module.r2_assets.custom_domains
}

output "event_notifications" {
  description = "Event notification configurations attached to the R2 bucket."
  value       = module.r2_assets.event_notifications
}
