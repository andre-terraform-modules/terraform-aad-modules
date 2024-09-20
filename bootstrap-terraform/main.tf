# Create an Azure AD Application
resource "azuread_application" "terraform_app" {
  display_name = "terraform-sp"
  logo_image   = filebase64("./main_tf.png")
  owners       = var.aad_owners
}

# Create a Service Principal for the Terraform Azure AD Application
resource "azuread_service_principal" "terraform_sp" {
  client_id = azuread_application.terraform_app.client_id
}

# Create a Client Secret for the Terraform Service Principal
resource "azuread_service_principal_password" "example" {
  service_principal_id = azuread_service_principal.example.object_id
}

# Assign Owner Role to the TF Service Principal at the Subscription level
resource "azurerm_role_assignment" "terraform_sp_role" {
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.terraform_sp.object_id
}