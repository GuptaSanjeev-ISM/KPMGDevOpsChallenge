##data/locals
locals {
  snet_names     = ["snet-${var.app_name}-${var.app_env}-client", "snet-${var.app_name}-${var.app_env}-backend", "snet-${var.app_name}-${var.app_env}-database"]
  nsg_names      = ["nsg-${var.app_name}-${var.app_env}-client", "nsg-${var.app_name}-${var.app_env}-backend", "nsg-${var.app_name}-${var.app_env}-database"]
  vnet_name      = "vnet-${var.app_name}-${var.app_env}-${var.region_code}"
  snet_ranges    = cidrsubnets(element(var.cidr_space, 0), 6, 8, 8, 8)
}
##variables
variable "cidr_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.4.0.0/16"]
}

variable "ddos_protection_plan" {
  description = "The set of DDoS protection plan configuration"
  type = object({
    enable = bool
    id     = string
  })
  default = null
}

##spec
module "vnet" {
  source               = "./modules/az-network"
  vnet_name            = local.vnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  vnet_location        = var.location
  address_space        = var.cidr_space
  subnet_prefixes      = local.snet_ranges
  subnet_names         = local.snet_names
  nsg_names            = local.nsg_names
  tags                 = local.common_tags
  ddos_protection_plan = var.ddos_protection_plan
  depends_on           = [azurerm_resource_group.rg]
}

##outputs
