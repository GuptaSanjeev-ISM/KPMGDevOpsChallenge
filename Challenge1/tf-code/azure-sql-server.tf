## data/local
locals {
  sql_name = "sql-${var.app_name}-${var.app_env}-${var.region_code}"
}
## variables
variable "sql_server_config" {
  type = map(any)
}
variable "dbs" {
  type = any
}
## spec
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
resource "azurerm_key_vault_secret" "sqlpasswd" {
  name         = "db-${local.sql_name}-pswd"
  value        = random_password.password.result
  key_vault_id = lookup({ for k, v in azurerm_key_vault.kv : k => v.id }, "backend")
  depends_on   = [azurerm_key_vault.kv]
  tags         = local.common_tags
}
resource "azurerm_mssql_server" "example" {
  name                         = local.sql_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = var.sql_server_config.version
  administrator_login          = var.sql_server_config.administrator_login
  administrator_login_password = azurerm_key_vault_secret.sqlpasswd.value
  depends_on                   = [azurerm_key_vault_secret.sqlpasswd]
  tags                         = local.common_tags
}

resource "azurerm_mssql_firewall_rule" "allowazureservices" {
  name             = "FirewallRuleForAllowingAzureServices"
  server_id        = azurerm_mssql_server.example.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database" "test" {
  for_each       = var.dbs
  name           = each.key
  server_id      = azurerm_mssql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = each.value == "Basic" ? 2 : 150
  sku_name       = each.value
  zone_redundant = false

  tags = local.common_tags
}



## outputs
