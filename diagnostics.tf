locals {
  diag_object = {
    "${var.naming_convention_info.name}" = {
      resource_id = [azurerm_key_vault.akv.id]
      log         = var.diag_object.log
      metric      = var.diag_object.metric
    }
  }
}

module "diagnostics" {
  source = "git::https://dev.azure.com/Brett-OJ/MerlionOptimised/_git/tf-module-az-diagnostic-settings?ref=master"

  log_analytics_workspace_id = var.diag_object.log_analytics_workspace_id
  diag_object                = local.diag_object
  naming_convention_info     = var.naming_convention_info
  resource_type              = "akvdiag"
  tags                       = var.tags
}