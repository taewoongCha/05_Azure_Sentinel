
resource "azurerm_monitor_data_collection_endpoint" "team4_dce" {
  name                = "team4-dce"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name
  kind                = "Linux"
}

resource "azurerm_monitor_data_collection_rule" "team4_dcr" {
  name                        = "team4-dcr"
  location                    = azurerm_resource_group.team4_rg.location
  resource_group_name         = azurerm_resource_group.team4_rg.name
  kind                        = "Linux"
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.team4_dce.id

  destinations {
    log_analytics {
      name                  = "logAnalyticsDest"
      workspace_resource_id = azurerm_log_analytics_workspace.team4_law.id
    }
  }

  data_sources {
    syslog {
      name           = "syslogSource"
      facility_names = ["*"]
      log_levels     = ["Info", "Warning", "Error", "Critical"]
      streams        = ["Microsoft-Syslog"]
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["logAnalyticsDest"]
  }
  depends_on = [ azurerm_monitor_data_collection_endpoint.team4_dce, azurerm_log_analytics_workspace.team4_law ]
}

resource "azurerm_monitor_data_collection_rule_association" "team4_bat_dcrasso" {
  name                    = "team4-bat-dcrasso"
  target_resource_id      = azurerm_linux_virtual_machine.team4_bat.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.team4_dcr.id
  depends_on = [ azurerm_linux_virtual_machine.team4_bat ]
}
resource "azurerm_monitor_data_collection_rule_association" "team4_web1_dcrasso" {
  name                    = "team4-bat-dcrasso"
  target_resource_id      = azurerm_linux_virtual_machine.team4_web1.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.team4_dcr.id
  depends_on = [ azurerm_linux_virtual_machine.team4_web1 ]
}
resource "azurerm_monitor_data_collection_rule_association" "team4_web2_dcrasso" {
  name                    = "team4-bat-dcrasso"
  target_resource_id      = azurerm_linux_virtual_machine.team4_web2.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.team4_dcr.id
  depends_on = [ azurerm_linux_virtual_machine.team4_web2 ]
}
resource "azurerm_monitor_data_collection_rule_association" "team4_ftp_dcrasso" {
  name                    = "team4-bat-dcrasso"
  target_resource_id      = azurerm_linux_virtual_machine.team4_ftp.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.team4_dcr.id
  depends_on = [ azurerm_linux_virtual_machine.team4_ftp ]
}
/*
resource "azurerm_monitor_data_collection_rule_association" "team4_onprem_dcrasso" {
  name                    = "team4-onprem-dcrasso"
  target_resource_id      = "/subscriptions/${var.subscription_id}/resourceGroups/02-team4-rg/providers/Microsoft.HybridCompute/machines/FTPSERV"
  data_collection_rule_id = azurerm_monitor_data_collection_rule.team4_dcr.id
  depends_on = [ azurerm_arc_machine_extension.team4_ftp_ama ]
}
*/