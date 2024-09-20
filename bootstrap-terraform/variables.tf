variable "aad_owners" {
  type = list(string)
  description = "Owners of AAD"
}

variable "terraform_sp_name" {
  type = string
  description = "Name of AAD app registration"
}