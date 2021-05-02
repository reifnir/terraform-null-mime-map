variable "custom_mappings" {
  description = "Add or replace content-type mappings by setting this value. Ex: `{ \"text\" = \"text/plain\", \"new\" = \"text/derp\" }` "
  default     = null
  type        = map(string)
}

output "mappings" {
  description = "A map of file extensions mapped to content-type/MIME-types."
  value       = (var.custom_mappings == null) ? local.content_type_mappings : merge(local.content_type_mappings, var.custom_mappings)
}
