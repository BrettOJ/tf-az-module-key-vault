locals {
  tags = {
    "created-by" = "Terraform"
 
  }

  naming_convention_info = {
    name         = "eg"
    project_code = "boj"
    env          = "dev"
    zone         = "z1"
    agency_code  = "brettoj"
    tier         = "web"
  }
}

module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = {

      }
    }
  }
}



module "akv_merlion" {
  source              = "git::https://github.com/BrettOJ/tf-az-module-key-vault?ref=main" 
  resource_group_name = module.resource_groups.rg_output[1].name
  location            = var.location
  sku                 = "premium"
  akv_policies = {
    sp2 = {
      object_id          = data.azurerm_client_config.current.object_id
      tenant_id          = data.azurerm_client_config.current.tenant_id
      key_permissions    = ["Create", "Get", "Delete", "Update"]
      secret_permissions = ["Get", "List", "Set"]
    }
  }
  network_acls = [
    {
      bypass         = "AzureServices"
      default_action = "Allow"
      ip_rules       = null
      subnet_ids     = null
    }
  ]

  akv_features = {
    enable_disk_encryption     = true
    enable_deployment          = true
    enable_template_deployment = true
  }
    diag_object = {
    log_analytics_workspace_id = module.merlion_law.loga_output.id
    enabled_log = [
      ["AuditEvent", true, 80],
    ]
    metric = [
      ["AllMetrics", true, 80],
    ]
  }
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
}