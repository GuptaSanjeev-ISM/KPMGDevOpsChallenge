resource "random_id" "ip_dns_client" {
  byte_length = 4
}

resource "random_password" "admin_password_client" {
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
  admin_password_client = coalesce(var.admin_password, random_password.admin_password_client.result)
  client_subnet_id      = lookup(module.vnet.vnet_subnets_name_id, "snet-${var.app_name}-${var.app_env}-client")
}

resource "azurerm_key_vault_secret" "admin_password_client" {
  name         = "vm-client-admin-pswd"
  value        = local.admin_password_client
  key_vault_id = lookup({ for k, v in azurerm_key_vault.kv : k => v.id }, "client")
  depends_on   = [azurerm_key_vault.kv]
  tags         = local.common_tags
}

module "clientserver" {
  source              = "./modules/az-vm"
  name                = "${random_id.ip_dns_client.hex}-client"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  admin_username      = var.admin_username
  admin_password      = local.admin_password_client
  image_os            = var.vm.client.image_os
  os_disk             = var.vm.client.os_disk
  os_simple           = var.vm.client.os_simple
  size                = var.vm.client.size
  # change to a unique name per datacenter region
  subnet_id                       = local.client_subnet_id
  disable_password_authentication = var.vm.client.disable_password_authentication
}