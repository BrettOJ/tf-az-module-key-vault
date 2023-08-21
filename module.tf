resource "azurerm_key_vault" "akv" {
  name                            = module.akv_name.naming_convention_output[var.naming_convention_info.name].names.0
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  tags                            = module.akv_name.naming_convention_output[var.naming_convention_info.name].tags.0
  sku_name                        = var.sku
  depends_on                      = [var.dependencies]
  enabled_for_disk_encryption     = var.akv_features.enable_disk_encryption
  enabled_for_deployment          = var.akv_features.enable_deployment
  enabled_for_template_deployment = var.akv_features.enable_template_deployment

  dynamic "network_acls" {
    for_each = var.network_acls
    content {
      default_action             = network_acls.value.default_action
      bypass                     = network_acls.value.bypass
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.subnet_ids
    }
  }
  purge_protection_enabled = var.purge_protection_enabled
}
