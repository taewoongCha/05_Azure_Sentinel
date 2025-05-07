resource "azurerm_role_assignment" "logicapp_ftp_nsg_perm" {
  scope                = azurerm_network_security_group.team4_ftp_nsg.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_logic_app_workflow.team4_lga.identity[0].principal_id

  depends_on = [
    azurerm_logic_app_workflow.team4_lga,
    azurerm_network_security_group.team4_ftp_nsg
  ]
}
resource "azurerm_role_assignment" "logicapp_web_nsg_perm" {
  scope                = azurerm_network_security_group.team4_web_nsg.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_logic_app_workflow.team4_lga.identity[0].principal_id

  depends_on = [
    azurerm_logic_app_workflow.team4_lga,
    azurerm_network_security_group.team4_web_nsg
  ]
}
resource "azurerm_role_assignment" "logicapp_bat_nsg_perm" {
  scope                = azurerm_network_security_group.team4_bat_nsg.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_logic_app_workflow.team4_lga.identity[0].principal_id

  depends_on = [
    azurerm_logic_app_workflow.team4_lga,
    azurerm_network_security_group.team4_bat_nsg
  ]
}
resource "azurerm_role_assignment" "logicapp_storage_blob" {
  scope                = azurerm_storage_account.team4_logbackup.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_logic_app_workflow.team4_lga.identity[0].principal_id
}
resource "azurerm_role_assignment" "team4_kv_reader" {
  scope                = azurerm_key_vault.team4_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = data.azurerm_client_config.current.object_id
}
