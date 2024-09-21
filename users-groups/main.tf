locals {
  users_by_group = flatten([
    for group_name, users in var.groups : [
      for user_email in users : {
        group = group_name
        email = user_email
      }
    ]
  ])
}

# Create Groups
resource "azuread_group" "group" {
  for_each = var.groups

  display_name     = each.key
  security_enabled = true
}

# Create users
resource "azuread_user" "user" {
  for_each = {
    for idx, user in local.users_by_group : "${user.group}-${user.email}" => user
  }

  user_principal_name   = each.value.email
  display_name          = split("@", each.value.email)[0]
  password              = "Password123!"
  force_password_change = false
}

# Bind Users to Groups
resource "azuread_group_member" "membership" {
  for_each = {
    for idx, user in local.users_by_group : "${user.group}-${user.email}" => user
  }

  group_object_id  = azuread_group.group[each.value.group].id
  member_object_id = azuread_user.user["${each.value.group}-${each.value.email}"].id
}