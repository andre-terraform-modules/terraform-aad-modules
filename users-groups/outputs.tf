output "group_ids" {
  value = azuread_group.group[*].id
}

output "user_ids" {
  value = azuread_user.user[*].id
}
