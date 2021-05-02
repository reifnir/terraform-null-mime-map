
module "no_custom_mappings" {
  source = "../../"
}

output "no_custom_mappings" {
  value = module.no_custom_mappings.mappings
}

module "overide_mappings" {
  source = "../../"
  custom_mappings = {
    "txt" = "derp"
  }
}

output "overide_mappings" {
  value = module.overide_mappings.mappings
}

module "add_mappings" {
  source = "../../"
  custom_mappings = {
    "herp" = "derp"
  }
}

output "add_mappings" {
  value = module.add_mappings.mappings
}
