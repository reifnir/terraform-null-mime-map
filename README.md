# terraform-mime-map

[![LICENSE](https://img.shields.io/github/license/reifnir/terraform-mime-map)](https://github.com/reifnir/terraform-mime-map/blob/master/LICENSE)

This Terraform module returns a map of file extensions to content/MIME types (no characterset encoding info). It also takes a map of custom types that can be used to augment the list with missing/custom types as well or override existing values.

## Usage example
 
See examples [here](https://github.com/reifnir/terraform-azurerm-azure-functions-static-site/tree/main/examples)

Basic example

 ```terraform
module "content_types" {
  source = "../../"
  name                     = "my-static-site"
  static_content_directory = "${path.root}/static-content"
  enable_app_insights      = false
}
 ```
 