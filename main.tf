locals {
  bucket_name = cloudflare_r2_bucket.this.name
}

resource "cloudflare_r2_bucket" "this" {
  account_id = var.account_id
  name       = var.name

  location      = var.location
  storage_class = var.storage_class
}

resource "cloudflare_r2_bucket_cors" "this" {
  count = var.cors == null ? 0 : 1

  account_id  = var.account_id
  bucket_name = local.bucket_name
  rules       = var.cors.rules
}

resource "cloudflare_r2_bucket_lifecycle" "this" {
  count = var.bucket_lifecycle == null ? 0 : 1

  account_id  = var.account_id
  bucket_name = local.bucket_name
  rules       = var.bucket_lifecycle.rules
}

resource "cloudflare_r2_bucket_lock" "this" {
  count = var.lock == null ? 0 : 1

  account_id  = var.account_id
  bucket_name = local.bucket_name
  rules       = var.lock.rules
}

resource "cloudflare_r2_bucket_sippy" "this" {
  count = var.sippy == null ? 0 : 1

  account_id  = var.account_id
  bucket_name = local.bucket_name

  source      = var.sippy.source
  destination = var.sippy.destination
}

resource "cloudflare_r2_managed_domain" "this" {
  count = var.managed_domain == null ? 0 : 1

  account_id  = var.account_id
  bucket_name = local.bucket_name
  enabled     = var.managed_domain.enabled
}

resource "cloudflare_r2_custom_domain" "this" {
  for_each = var.custom_domains

  account_id  = var.account_id
  bucket_name = local.bucket_name
  domain      = each.value.domain
  zone_id     = each.value.zone_id
  enabled     = each.value.enabled

  min_tls = each.value.min_tls
  ciphers = each.value.ciphers
}

resource "cloudflare_r2_bucket_event_notification" "this" {
  for_each = var.event_notifications

  account_id  = var.account_id
  bucket_name = local.bucket_name
  queue_id    = each.value.queue_id
  rules       = each.value.rules
}
