# data/local
locals {
  rg_name = "rg-${var.app_name}-${var.app_env}-${var.region_code}"
}
## variables
## spec
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

##output

