resource "azurerm_storage_account" "team4_logbackup" {
  name                     = "team4logbackup"
  resource_group_name      = azurerm_resource_group.team4_rg.name
  location                 = azurerm_resource_group.team4_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity{
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "logicapp_backup" {
  name                  = "logicapp-backup"
  storage_account_name  = azurerm_storage_account.team4_logbackup.name
  container_access_type = "private"
}
resource "azurerm_role_assignment" "blob_ass_st1" {
  scope                = azurerm_storage_account.team4_logbackup.id
  role_definition_name = "Owner"
  principal_id         = data.azuread_user.student1.object_id
}
resource "azurerm_role_assignment" "blob_ass_st2" {
  scope                = azurerm_storage_account.team4_logbackup.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = data.azuread_user.student2.object_id
}
resource "azurerm_role_assignment" "blob_ass_st3" {
  scope                = azurerm_storage_account.team4_logbackup.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = data.azuread_user.student3.object_id
}
resource "azurerm_role_assignment" "blob_ass_st4" {
  scope                = azurerm_storage_account.team4_logbackup.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = data.azuread_user.student4.object_id
}
/*
resource "azurerm_role_assignment" "blob_ass_st5" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.student3.object_id
}
resource "azurerm_role_assignment" "blob_ass_st6" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.student2.object_id
}
*/