resource "random_id" "ip_dns_backend" {
  byte_length = 4
}

resource "random_password" "admin_password_backend" {
  length      = 20
  lower       = true
  min_lower   = 1
  min_numeric = 1
  min_special = 1
  min_upper   = 1
  numeric     = true
  special     = true
  upper       = true
}

locals {
  admin_password_backend = coalesce(var.admin_password, random_password.admin_password_backend.result)
  backend_subnet_id                      = lookup(module.vnet.vnet_subnets_name_id, "snet-${var.app_name}-${var.app_env}-backend")
}

resource "azurerm_key_vault_secret" "admin_password_backend" {
  name         = "vm-backend-admin-pswd"
  value        = local.admin_password_backend
  key_vault_id = lookup({ for k, v in azurerm_key_vault.kv : k => v.id }, "backend")
  depends_on   = [azurerm_key_vault.kv]
  tags         = local.common_tags
}

module "backendserver" {
  source              = "./modules/az-vm"
  name         = "${random_id.ip_dns_backend.hex}-backend"
  resource_group_name  = azurerm_resource_group.rg.name
  location            = var.location
  admin_username      = var.admin_username
  admin_password      = local.admin_password_backend
  image_os        = var.vm.backend.image_os
  os_disk = var.vm.backend.os_disk
  os_simple = var.vm.backend.os_simple
  size                       = var.vm.backend.size
  # change to a unique name per datacenter region
  subnet_id                   = local.backend_subnet_id
  disable_password_authentication = var.vm.backend.disable_password_authentication
}