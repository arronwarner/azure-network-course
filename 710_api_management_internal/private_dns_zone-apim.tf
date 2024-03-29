/* Creates a Private DNS ZOne, A Records and Vnet Link for each of the below endpoints
API Gateway	                contosointernalvnet.azure-api.net
Developer portal	        contosointernalvnet.portal.azure-api.net
The new developer portal	contosointernalvnet.developer.azure-api.net
Direct management endpoint	contosointernalvnet.management.azure-api.net
Git	                        contosointernalvnet.scm.azure-api.net */

#-------------------------------
# DNS zones 
#-------------------------------
resource "azurerm_private_dns_zone" "gateway" {
  name                = "azure-api.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone" "dev_portal" {
  name                = "portal.azure-api.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone" "new_dev_portal" {
  name                = "developer.azure-api.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone" "mgmt_portal" {
  name                = "management.azure-api.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone" "scm" {
  name                = "scm.azure-api.net"
  resource_group_name = azurerm_resource_group.rg.name
}

#-------------------------------
# A records for the DNS zones
#-------------------------------
resource "azurerm_private_dns_a_record" "gateway_record" {
  name                = azurerm_api_management.apim.name
  zone_name           = azurerm_private_dns_zone.gateway.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 36000
  records             = azurerm_api_management.apim.private_ip_addresses
}

resource "azurerm_private_dns_a_record" "dev_portal_record" {
  name                = azurerm_api_management.apim.name
  zone_name           = azurerm_private_dns_zone.dev_portal.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = azurerm_api_management.apim.private_ip_addresses
}

resource "azurerm_private_dns_a_record" "new_dev_portal_record" {
  name                = azurerm_api_management.apim.name
  zone_name           = azurerm_private_dns_zone.new_dev_portal.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = azurerm_api_management.apim.private_ip_addresses
}

resource "azurerm_private_dns_a_record" "mgmt_portal_record" {
  name                = azurerm_api_management.apim.name
  zone_name           = azurerm_private_dns_zone.mgmt_portal.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = azurerm_api_management.apim.private_ip_addresses
}

resource "azurerm_private_dns_a_record" "scm_record" {
  name                = azurerm_api_management.apim.name
  zone_name           = azurerm_private_dns_zone.scm.name
  resource_group_name = azurerm_resource_group.rg.name
  ttl                 = 300
  records             = azurerm_api_management.apim.private_ip_addresses
}

#-------------------------------
# Vnet links
#-------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "gateway_vnetlink" {
  name                  = "gateway-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.gateway.name
  virtual_network_id    = azurerm_virtual_network.vnet-app.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "dev_portal_vnetlink" {
  name                  = "portal-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dev_portal.name
  virtual_network_id    = azurerm_virtual_network.vnet-app.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "new_dev_portal_vnetlink" {
  name                  = "dev-portal-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.new_dev_portal.name
  virtual_network_id    = azurerm_virtual_network.vnet-app.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "mgmt_vnetlink" {
  name                  = "mgmt-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.mgmt_portal.name
  virtual_network_id    = azurerm_virtual_network.vnet-app.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "scm_vnetlink" {
  name                  = "scm-vnet-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.scm.name
  virtual_network_id    = azurerm_virtual_network.vnet-app.id
}