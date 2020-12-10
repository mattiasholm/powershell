locals {
  keyvaultName = "${local.prefix}-KeyVault01"
  keyvaultSku  = "standard"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                = local.keyvaultName
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = local.keyvaultSku

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "get",
    ]
    certificate_permissions = [
      "get",
    ]
  }
}

output "keyvautUrl" {
  value = azurerm_key_vault.keyvault.vault_uri
}
