module "r2_assets" {
  source = "../.."

  account_id    = var.cloudflare_account_id
  name          = "assets-prod"
  location      = "weur"
  storage_class = "Standard"

  cors = {
    rules = [
      {
        allowed = {
          methods = ["GET", "HEAD"]
          origins = ["https://example.com"]
          headers = ["*"]
        }
        id              = "frontend"
        expose_headers  = ["Content-Length", "Content-Encoding"]
        max_age_seconds = 3600
      }
    ]
  }

  bucket_lifecycle = {
    rules = [
      {
        id      = "archive-old-objects"
        enabled = true
        conditions = {
          prefix = "archive/"
        }
        storage_class_transitions = [
          {
            condition = {
              max_age = 86400
              type    = "Age"
            }
            storage_class = "InfrequentAccess"
          }
        ]
      }
    ]
  }

  lock = {
    rules = [
      {
        id      = "protect-backups"
        enabled = true
        prefix  = "backup/"
        condition = {
          max_age_seconds = 604800
          type            = "Age"
        }
      }
    ]
  }

  managed_domain = var.enable_managed_domain ? {
    enabled = true
  } : null

  custom_domains = var.zone_id != null && var.custom_domain != null ? {
    public = {
      domain  = var.custom_domain
      zone_id = var.zone_id
      enabled = true
      min_tls = "1.2"
    }
  } : {}

  event_notifications = var.queue_id == null ? {} : {
    images = {
      queue_id = var.queue_id
      rules = [
        {
          actions     = ["PutObject", "CopyObject"]
          description = "Images upload events"
          prefix      = "img/"
          suffix      = ".webp"
        }
      ]
    }
  }
}
