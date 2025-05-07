resource "azurerm_logic_app_workflow" "team4_lga" {
  name                = "team4-lga"
  location            = azurerm_resource_group.team4_rg.location
  resource_group_name = azurerm_resource_group.team4_rg.name
  enabled = true

  identity {
    type = "SystemAssigned"
  }
}
resource "azurerm_resource_group_template_deployment" "team4_logicapp_deploy" {
  name                = "team4-logicapp-deployment"
  resource_group_name = azurerm_resource_group.team4_rg.name
  deployment_mode     = "Incremental"

  template_content = file("${path.module}/files/logicapp_total.json")

  parameters_content = jsonencode({
    logicAppName = {
      value = "team4-lga"
    }
  })
  depends_on = [ azurerm_api_connection.team4_smtp_connection, azurerm_logic_app_workflow.team4_lga, azurerm_api_connection.azureblob]
}