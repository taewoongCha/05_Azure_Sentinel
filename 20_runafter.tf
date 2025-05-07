
/*
resource "azurerm_monitor_action_group" "team4_mag" {
  name                = "team4-mag"
  resource_group_name = azurerm_resource_group.team4_rg.name
  short_name          = "team4act"

  webhook_receiver {
    name                    = "team4-logicapp"
    service_uri            = "https://prod-08.koreacentral.logic.azure.com:443/workflows/829af4b56e0948568862fb7822b1bd32/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=NeEhzGOiVfGABkDrgrSvupgN1wSj6kgOg95pgrBpRIc"
    use_common_alert_schema = true
  }
}
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "team4_failed_login_alert" {
  name                = "failed-login-alert"
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_log_analytics_workspace.team4_law.location
  display_name        = "Failed Login Attempts Detection"
  description         = "Monitor critical syslog events for failed login attempts."
  enabled             = true
  severity            = 2
  scopes              = [azurerm_log_analytics_workspace.team4_law.id]

  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"

  criteria {
    query                   = <<QUERY
Syslog 
| where SyslogMessage has_any ("invalid user", "Failed password") 
| extend timestamp = TimeGenerated, AccountCustomEntity = extract(@"user (\\w+)", 1, SyslogMessage)
QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0
  }

  action {
    action_groups = [azurerm_monitor_action_group.team4_mag.id]
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "team4_secret_download_alert" {
  name                = "team4-secret-download-alert"
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_log_analytics_workspace.team4_law.location
  display_name        = "secret-download-detection"
  description         = "Alert when secret files are downloaded from FTP server"
  enabled             = true
  severity            = 2
  scopes              = [azurerm_log_analytics_workspace.team4_law.id]

  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"

  criteria {
    query                   = <<QUERY
Syslog
| where Facility == "ftp"
| where SyslogMessage has_any ("secretA.txt", "secretS.txt")
QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0
  }

  action {
    action_groups = [azurerm_monitor_action_group.team4_mag.id]
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "team4_secret_upload_alert" {
  name                = "team4-secret-upload-alert"
  resource_group_name = azurerm_resource_group.team4_rg.name
  location            = azurerm_log_analytics_workspace.team4_law.location
  display_name        = "secret-upload-detection"
  description         = "Alert when secret files are uploaded from FTP server"
  enabled             = true
  severity            = 2
  scopes              = [azurerm_log_analytics_workspace.team4_law.id]

  evaluation_frequency = "PT5M"
  window_duration      = "PT5M"

  criteria {
    query                   = <<QUERY
Syslog
| where Facility == "ftp" or Facility contains "daemon"
| where SyslogMessage contains "STOR"
| where SyslogMessage matches regex @".*\.(exe|sh|bat|php|py|dll|js|bin|pl|jar)\b"
QUERY
    time_aggregation_method = "Count"
    operator                = "GreaterThan"
    threshold               = 0
  }

  action {
    action_groups = [azurerm_monitor_action_group.team4_mag.id]
  }

  tags = {
    environment = "production"
  }
}
*/
