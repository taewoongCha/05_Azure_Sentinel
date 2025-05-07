resource "azurerm_log_analytics_workspace" "team4_law" {
  name                = "team4-law"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  //  depends_on          = [random_string.law_random]
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "team4_sentinel" {
  workspace_id = azurerm_log_analytics_workspace.team4_law.id
}
resource "azurerm_virtual_machine_extension" "team4_bat_ama" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.team4_bat.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.15"
  auto_upgrade_minor_version = true
}
resource "azurerm_virtual_machine_extension" "team4_web1_ama" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.team4_web1.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.15"
  auto_upgrade_minor_version = true
}
resource "azurerm_virtual_machine_extension" "team4_web2_ama" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.team4_web2.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.15"
  auto_upgrade_minor_version = true
}
resource "azurerm_virtual_machine_extension" "team4_ftp_ama" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.team4_ftp.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.15"
  auto_upgrade_minor_version = true
}
/*
resource "azurerm_arc_machine_extension" "team4_ftp_ama" {
  name           = "team4-ftp-ama"
  location       = azurerm_resource_group.team4_rg.location
  arc_machine_id = data.azurerm_arc_machine.team4_ftpserv.id
  publisher      = "Microsoft.Azure.Monitor"
  type           = "AzureMonitorLinuxAgent"
  depends_on = [ azurerm_linux_virtual_machine.team4_bat ]
}
*/
resource "azurerm_sentinel_alert_rule_scheduled" "ssh_failed_detection" {
  name                       = "SSH_Failed_Login_Detection"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.team4_law.id
  display_name               = "SSH Failed Login Detection"
  severity                   = "Medium"
  query_frequency            = "PT5M"
  query_period               = "PT5M"
  trigger_operator           = "GreaterThan"
  trigger_threshold          = 3
  enabled                    = true

  query = <<QUERY
Syslog 
| where SyslogMessage has_any ("invalid user", "Failed password") 
| extend timestamp = TimeGenerated, AccountCustomEntity = extract(@"user (\\w+)", 1, SyslogMessage)
QUERY
}

resource "azurerm_sentinel_alert_rule_scheduled" "FTP_Download" {
  name                       = "FTP-Secret-Download-Detection"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.team4_law.id
  display_name               = "FTP Secret Download Detection"
  severity                   = "Medium"
  query_frequency            = "PT5M"
  query_period               = "PT5M"
  trigger_operator           = "GreaterThan"
  trigger_threshold          = 0
  enabled                    = true

  query = <<QUERY
Syslog
| where Facility == "ftp"
| where SyslogMessage has_any ("secretA.txt", "secretS.txt")
QUERY
}

resource "azurerm_sentinel_alert_rule_scheduled" "FTP_Upload" {
  name                       = "FTP_Illegal_Upload-Detection"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.team4_law.id
  display_name               = "FTP_Illegal_Upload-Detection"
  severity                   = "Medium"
  query_frequency            = "PT5M"
  query_period               = "PT5M"
  trigger_operator           = "GreaterThan"
  trigger_threshold          = 0
  enabled                    = true

  query = <<QUERY
Syslog
| where Facility == "ftp" or Facility contains "daemon"
| where SyslogMessage contains "STOR"
| where SyslogMessage matches regex @".*\.(exe|sh|bat|php|py|dll|js|bin|pl|jar)\b"
QUERY
}