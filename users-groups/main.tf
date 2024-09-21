# Create Groups
resource "azuread_group" "group" {
  for_each = var.groups

  display_name = each.key
}

# Create users
resource "azuread_user" "user" {
  count = length(flatten([for group in var.groups : group.value]))

  user_principal_name = flatten([for group in var.groups : group.value])[count.index]
  display_name        = flatten([for group in var.groups : group.value])[count.index]
  password            = "Password123!"
  force_password_change = false
}


