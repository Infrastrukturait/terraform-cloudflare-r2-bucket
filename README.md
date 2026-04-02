
# terraform-cloudflare-r2-bucket

[![WeSupportUkraine](https://raw.githubusercontent.com/Infrastrukturait/WeSupportUkraine/main/banner.svg)](https://github.com/Infrastrukturait/WeSupportUkraine)
## About
Terraform module to provision a [CloudFlare R2 bucket](https://developers.cloudflare.com/r2/).
## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

```text
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Source: <https://opensource.org/licenses/MIT>
```
See [LICENSE](LICENSE) for full details.
## Authors
- Rafał Masiarek | [website](https://masiarek.pl) | [email](mailto:rafal@masiarek.pl) | [github](https://github.com/rafalmasiarek)
<!-- BEGIN_TF_DOCS -->
## Documentation


### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | >= 5.18.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [cloudflare_r2_bucket.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_bucket) | resource |
| [cloudflare_r2_bucket_cors.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_bucket_cors) | resource |
| [cloudflare_r2_bucket_event_notification.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_bucket_event_notification) | resource |
| [cloudflare_r2_bucket_lifecycle.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_bucket_lifecycle) | resource |
| [cloudflare_r2_bucket_lock.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_bucket_lock) | resource |
| [cloudflare_r2_bucket_sippy.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_bucket_sippy) | resource |
| [cloudflare_r2_custom_domain.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_custom_domain) | resource |
| [cloudflare_r2_managed_domain.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/r2_managed_domain) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | Cloudflare account ID. | `string` | n/a | yes |
| <a name="input_bucket_lifecycle"></a> [bucket\_lifecycle](#input\_bucket\_lifecycle) | Optional R2 bucket lifecycle configuration. | <pre>object({<br>    rules = optional(list(object({<br>      id = string<br>      conditions = optional(object({<br>        prefix = string<br>      }))<br>      enabled = bool<br><br>      abort_multipart_uploads_transition = optional(object({<br>        condition = optional(object({<br>          max_age = number<br>          type    = string<br>        }))<br>      }))<br><br>      delete_objects_transition = optional(object({<br>        condition = optional(object({<br>          max_age = optional(number)<br>          type    = string<br>          date    = optional(string)<br>        }))<br>      }))<br><br>      storage_class_transitions = optional(list(object({<br>        condition = object({<br>          max_age = optional(number)<br>          type    = string<br>          date    = optional(string)<br>        })<br>        storage_class = string<br>      })), [])<br>    })), [])<br>  })</pre> | `null` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | Optional R2 bucket CORS configuration. | <pre>object({<br>    rules = optional(list(object({<br>      allowed = object({<br>        methods = list(string)<br>        origins = list(string)<br>        headers = optional(list(string))<br>      })<br>      id              = optional(string)<br>      expose_headers  = optional(list(string))<br>      max_age_seconds = optional(number)<br>    })), [])<br>  })</pre> | `null` | no |
| <a name="input_custom_domains"></a> [custom\_domains](#input\_custom\_domains) | Optional map of custom domains attached to the bucket. | <pre>map(object({<br>    domain  = string<br>    zone_id = string<br>    enabled = bool<br>    min_tls = optional(string)<br>    ciphers = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_event_notifications"></a> [event\_notifications](#input\_event\_notifications) | Optional map of R2 bucket event notifications. | <pre>map(object({<br>    queue_id = string<br>    rules = list(object({<br>      actions     = list(string)<br>      description = optional(string)<br>      prefix      = optional(string)<br>      suffix      = optional(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Optional R2 bucket location. | `string` | `null` | no |
| <a name="input_lock"></a> [lock](#input\_lock) | Optional R2 bucket object lock configuration. | <pre>object({<br>    rules = optional(list(object({<br>      id = string<br>      condition = object({<br>        max_age_seconds = optional(number)<br>        type            = string<br>        date            = optional(string)<br>      })<br>      enabled = bool<br>      prefix  = optional(string)<br>    })), [])<br>  })</pre> | `null` | no |
| <a name="input_managed_domain"></a> [managed\_domain](#input\_managed\_domain) | Optional managed r2.dev domain configuration. | <pre>object({<br>    enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | R2 bucket name. | `string` | n/a | yes |
| <a name="input_sippy"></a> [sippy](#input\_sippy) | Optional R2 bucket Sippy configuration. | <pre>object({<br>    source = optional(object({<br>      access_key_id            = optional(string)<br>      bucket                   = optional(string)<br>      r2_bucket_sippy_provider = optional(string)<br>      region                   = optional(string)<br>      secret_access_key        = optional(string)<br>      client_email             = optional(string)<br>      private_key              = optional(string)<br>      bucket_url               = optional(string)<br>    }))<br>    destination = optional(object({<br>      access_key_id            = optional(string)<br>      r2_bucket_sippy_provider = optional(string)<br>      secret_access_key        = optional(string)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Optional default storage class for newly uploaded objects. | `string` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | R2 bucket resource. |
| <a name="output_bucket_lifecycle"></a> [bucket\_lifecycle](#output\_bucket\_lifecycle) | R2 bucket lifecycle configuration. |
| <a name="output_cors"></a> [cors](#output\_cors) | R2 bucket CORS configuration. |
| <a name="output_custom_domains"></a> [custom\_domains](#output\_custom\_domains) | Custom domains attached to the bucket. |
| <a name="output_event_notifications"></a> [event\_notifications](#output\_event\_notifications) | R2 bucket event notifications. |
| <a name="output_lock"></a> [lock](#output\_lock) | R2 bucket lock configuration. |
| <a name="output_managed_domain"></a> [managed\_domain](#output\_managed\_domain) | Managed r2.dev domain configuration. |
| <a name="output_sippy"></a> [sippy](#output\_sippy) | R2 bucket Sippy configuration. |

### Examples

```hcl
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
```

<!-- END_TF_DOCS -->

<!-- references -->

[repo_link]: https://github.com/Infrastrukturait/terraform-cloudflare-r2-bucket
