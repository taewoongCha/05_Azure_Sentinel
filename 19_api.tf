resource "azurerm_api_connection" "team4_smtp_connection" {
  name                = "team4-smtp-connection"
  resource_group_name = azurerm_resource_group.team4_rg.name

  managed_api_id = "/subscriptions/${var.subscription_id}/providers/Microsoft.Web/locations/${var.loc}/managedApis/smtp"

  parameter_values = {
    "serverAddress" = "smtp.gmail.com"
    "username"      = var.smtp_username
    "password"      = var.smtp_password
  }

  tags = {
    environment = "production"
  }
}
resource "azurerm_api_connection" "azureblob" {
  name                = "team4-blob-connection"
  resource_group_name = azurerm_resource_group.team4_rg.name
  managed_api_id      = "/subscriptions/${var.subscription_id}/providers/Microsoft.Web/locations/${var.loc}/managedApis/azureblob"

  parameter_values = {
    "accountName" = azurerm_storage_account.team4_logbackup.name
    "accessKey"   = data.azurerm_key_vault_secret.team4_blob_key.value
  }
}