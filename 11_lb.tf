resource "azurerm_lb" "team4_lb" {
  name                = "team4-lb"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.team4_pubip_lb.id
  }
}
resource "azurerm_lb_backend_address_pool" "team4_lbbe" {
  loadbalancer_id = azurerm_lb.team4_lb.id
  name            = "team4-lbbe"
}
resource "azurerm_lb_probe" "team4_http_probe" {
  name                = "team4-http-probe"
  loadbalancer_id     = azurerm_lb.team4_lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "team4_http_rule" {
  name                           = "team4-http-rule"
  loadbalancer_id                = azurerm_lb.team4_lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.team4_http_probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "team4_lbbe_1" {
  network_interface_id    = azurerm_network_interface.team4_web1_nic.id
  ip_configuration_name   = "team4-web1-nic-conf"
  backend_address_pool_id = azurerm_lb_backend_address_pool.team4_lbbe.id
}
resource "azurerm_network_interface_backend_address_pool_association" "team4_lbbe_2" {
  network_interface_id    = azurerm_network_interface.team4_web2_nic.id
  ip_configuration_name   = "team4-web2-nic-conf"
  backend_address_pool_id = azurerm_lb_backend_address_pool.team4_lbbe.id
}