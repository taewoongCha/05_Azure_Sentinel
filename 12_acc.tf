resource "azurerm_role_assignment" "student211_reader" {
  scope                = azurerm_resource_group.team4_rg.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_user.student2.object_id
}

resource "azurerm_role_assignment" "student211_vm_admin" {
  scope                = azurerm_resource_group.team4_rg.id
  role_definition_name = "Virtual Machine Administrator Login"
  principal_id         = data.azuread_user.student2.object_id
}

resource "azurerm_role_assignment" "student211_smb_reader" {
  scope                = azurerm_storage_account.team4_logbackup.id
  role_definition_name = "Storage File Data SMB Share Reader"
  principal_id         = data.azuread_user.student2.object_id
}
resource "azurerm_role_assignment" "student210_reader" {
  scope                = azurerm_resource_group.team4_rg.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_user.student3.object_id
}

resource "azurerm_role_assignment" "student210_security_reader" {
   scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Security Reader"
  principal_id         = data.azuread_user.student3.object_id
}

resource "azurerm_role_assignment" "student210_smb_reader" {
  scope                = azurerm_storage_account.team4_logbackup.id
  role_definition_name = "Storage File Data SMB Share Reader"
  principal_id         = data.azuread_user.student3.object_id
}

resource "azurerm_role_assignment" "student4_reader" {
  scope                = azurerm_resource_group.team4_rg.id
  role_definition_name = "Reader"
  principal_id         = data.azuread_user.student4.object_id
}

resource "azurerm_role_assignment" "student4_storage_key_operator" {
  scope                = azurerm_storage_account.team4_logbackup.id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = data.azuread_user.student4.object_id
}

resource "azurerm_role_assignment" "student211_vm_admin2" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.student2.object_id
}
resource "azurerm_role_assignment" "student210_security_reader2" {
   scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.student3.object_id
}
resource "azurerm_role_assignment" "student203_security_reader" {
   scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.student4.object_id
}