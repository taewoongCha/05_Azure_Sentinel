resource "azurerm_public_ip" "team4_pubip_bat" {
  name                = "team4-bat-ip"
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_resource_group.team4_rg.location
  allocation_method   = "Static"
}
resource "azurerm_public_ip" "team4_pubip_nat" {
  name                = "team4-nat-ip"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_public_ip" "team4_pubip_lb" {
  name                = "team4-lb-ip"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name
  allocation_method   = "Static"
}
resource "azurerm_public_ip" "team4_pubip_ftp" {
  name                = "team4-ftp-ip"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name
  allocation_method   = "Static"
}