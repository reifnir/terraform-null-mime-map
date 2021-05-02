# terraform-null-mime-map

[![LICENSE](https://img.shields.io/github/license/reifnir/terraform-mime-map)](https://github.com/reifnir/terraform-mime-map/blob/master/LICENSE)

This Terraform module returns a map of file extensions to content/MIME types (no characterset encoding info).

It also takes a map of custom types that can be used to augment the list with missing/custom types as well or override existing values.

There is no reference or dependency on the Hashicorp null Terraform provider. There aren't actually ANY Terraform providers used in this module. The reason that this is listed under the null provider is because no providers are necessary.

## Why would I want to use this?

Do you need to apply content-type or MIME-type values to files that you're uploading to a CDN, blob or S3 storage?

This module removes the need for you to have to manage your own map of MIME-types for most cases.

## Usage examples

Basic example

 ```terraform
# A returns a map of file extensions-to-content-type values
module "file_extensions" {
  source  = "reifnir/mime-map/null"
}

# Access mappings through the module's `mappings` output
locals {
  default_mappings = module.file_extensions.mappings
}
 ```

Example replacing one mapped extension and adding a custom one type

 ```terraform
# A returns a map of file extensions-to-content-type values
module "file_extensions" {
  source  = "reifnir/mime-map/null"
  custom_mappings = {
    "txt" = "plain/herp"
    "text" = "plain/derp"
  }
}
 ```

