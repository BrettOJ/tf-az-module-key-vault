variable "sku" {
  type        = string
  description = "(Required) The SKU of the storage account."
}

variable "akv_policies" {
  type = map(object({
    object_id       = string
    tenant_id       = string
    key_permissions = list(string)
    #[backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify, wrapKey]
    secret_permissions = list(string)
    #[backup, delete, get, list, purge, recover, restore and set]
  }))
  default = null
}

variable "network_acls" {
  type = list(object({
    default_action = string
    bypass         = string
    ip_rules       = list(string)
    subnet_ids     = list(string)
  }))
}

variable "akv_features" {
  type = object({
    enable_disk_encryption     = bool
    enable_deployment          = bool
    enable_template_deployment = bool
  })

  default = {
    enable_disk_encryption     = true
    enable_deployment          = true
    enable_template_deployment = true
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

variable "location" {
  type        = string
  default     = ""
  description = "The name of the location."
}

variable "diag_object" {
  description = "contains the logs and metrics for diagnostics"
  default     = null
  type = object({
    log_analytics_workspace_id = string
    enabled_log                = list(tuple([string, bool, number]))
    metric                     = list(tuple([string, bool, number]))
  })
}

variable "naming_convention_info" {
  description = "(Required) Specify the naming convention information to the resource."
  type = object({
    name         = string
    project_code = string
    agency_code  = string
    env          = string
    zone         = string
    tier         = string
  })
}

variable "tags" {
  type        = map(string)
  description = "Specify the tags to the resource. Additional tags will be appended based on the convention"
}

variable "dependencies" {
  description = "List of dependecies modules or resources"
  default     = null
}

variable "purge_protection_enabled" {
  default = true
}
