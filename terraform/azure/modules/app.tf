locals {
  planName = "${local.prefix}-AppPlan01"
  planKind = "app"
}

resource "azurerm_app_service_plan" "plan" {
  name                = local.planName
  resource_group_name = var.rgName
  location            = var.rgLocation
  tags                = var.rgTags
  kind                = local.planKind
  sku {
    tier     = var.planTier
    size     = var.planSize
    capacity = var.planCapacity
  }
}



locals {
  appName      = "${local.prefix}-App01"
  appHttpsOnly = true
}

resource "azurerm_app_service" "app" {
  name                = local.appName
  resource_group_name = var.rgName
  location            = var.rgLocation
  tags                = var.rgTags
  app_service_plan_id = azurerm_app_service_plan.plan.id
  https_only          = local.appHttpsOnly
}

output "appUrl" {
  value = azurerm_app_service.app.default_site_hostname
}
