resource "azurerm_key_vault" "team4_kv" {
  name                        = "team4-kv"
  location                    = azurerm_resource_group.team4_rg.location
  resource_group_name         = azurerm_resource_group.team4_rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  soft_delete_retention_days = 7
  purge_protection_enabled   = false
}
resource "azurerm_key_vault_access_policy" "allow_terraform_user" {
  key_vault_id = azurerm_key_vault.team4_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get", "Set", "List"
  ]
}
/*
resource "azurerm_key_vault_secret" "team4_blob_key" {
  name         = "team4-blob-key"
  value        = azurerm_storage_account.team4_logbackup.primary_access_key
  key_vault_id = azurerm_key_vault.team4_kv.id
  depends_on = [ azurerm_key_vault_access_policy.allow_terraform_user ]
}
*/
