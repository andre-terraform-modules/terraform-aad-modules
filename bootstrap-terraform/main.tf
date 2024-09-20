# Create an Azure AD terraform dedicated app
resource "azuread_application" "terraform_app" {
  display_name = var.terraform_sp_name
  logo_image   = filebase64("./main_tf.png")
  owners       = var.aad_owners
}

# Create a Service Principal for the Terraform Azure AD Application
resource "azuread_service_principal" "terraform_sp" {
  client_id = azuread_application.terraform_app.client_id
}

# Create a Client Secret for the Terraform Service Principal
resource "azuread_service_principal_password" "terraform_sp_password" {
  service_principal_id = azuread_service_principal.terraform_sp.object_id
}

# Grant TF service principal AAD Global Admin rights
resource "azuread_directory_role_assignment" "global_administrator" {
  role_id             = "62e90394-69f5-4237-9190-012177145e10" # Global Administrator templateID
  principal_object_id = azuread_service_principal.terraform_sp.object_id
}