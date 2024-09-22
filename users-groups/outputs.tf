output "group_ids" {
  value = [for g in values(azuread_group.group) : g.id]
}

output "user_ids" {
  value = [for user in local.users_by_group : azuread_user.user["${user.group}-${user.email}"].id]
}
