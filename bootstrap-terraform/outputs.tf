output "client_id" {
  value = azuread_service_principal.terraform_sp.client_id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "client_secret" {
  value     = azuread_service_principal_password.terraform_sp_password.value
  sensitive = true
}