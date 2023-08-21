data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "kv_policy" {
  for_each     = var.akv_policies == null ? {} : var.akv_policies
  key_vault_id = azurerm_key_vault.akv.id

  tenant_id = each.value.tenant_id
  object_id = each.value.object_id

  key_permissions = each.value.key_permissions

  secret_permissions = each.value.secret_permissions
}
