resource "azurerm_network_security_rule" "appgw_nsg_rule_1" {
  name                        = "allow-incoming-traffic-GatewayManager"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "65200-65535"
  source_address_prefixes     = ["GatewayManager"]
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.vnet.name
  network_security_group_name = var.appgw_nsg_name
  depends_on                  = [azurerm_network_security_group.nsg]
}

resource "azurerm_network_security_rule" "appgw_nsg_rule_2" {
  name                        = "allow-incoming-traffic-AzureLoadBalancer"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefixes     = ["AzureLoadBalancer"]
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.vnet.name
  network_security_group_name = var.appgw_nsg_name
  depends_on                  = [azurerm_network_security_group.nsg]
}


resource "azurerm_network_security_rule" "appgw_nsg_rule_3" {
  name                        = "allow-incoming-traffic-443"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = azurerm_application_gateway.agic.frontend_ip_configuration.0.public_ip_address
  resource_group_name         = data.azurerm_resource_group.vnet.name
  network_security_group_name = var.appgw_nsg_name
  depends_on                  = [azurerm_network_security_group.nsg]
}