locals {
  diag_object = {
    "${var.naming_convention_info.name}" = {
      resource_id = [azurerm_key_vault.akv.id]
      enabled_log = var.diag_object.enabled_log
      metric      = var.diag_object.metric
    }
  }
}

module "diagnostics" {
  source = "git::https://github.com/BrettOJ/tf-az-module-diagnostic-settings?ref=main"

  log_analytics_workspace_id = var.diag_object.log_analytics_workspace_id
  diag_object                = local.diag_object
  naming_convention_info     = var.naming_convention_info
  resource_type              = "akvdiag"
  tags                       = var.tags
}