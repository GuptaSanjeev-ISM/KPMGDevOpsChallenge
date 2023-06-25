## data/local
data "azurerm_client_config" "current_user" {}
## variables
variable "kv_config" {
  type = any
}

## spec
resource "azurerm_key_vault" "kv" {
  for_each                    = var.kv_config
  name                        = "kv-${each.key}-${var.app_name}-${var.region_code}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current_user.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_days
  purge_protection_enabled    = each.value.purge_protection
  sku_name                    = each.value.sku
  access_policy {
    object_id               = data.azurerm_client_config.current_user.object_id
    tenant_id               = data.azurerm_client_config.current_user.tenant_id
    key_permissions         = each.value.key_permissions
    secret_permissions      = each.value.secret_permissions
    certificate_permissions = each.value.certificate_permissions
  }
  tags = local.common_tags
  lifecycle {
    ignore_changes = [
      access_policy,
    ]
  }
}