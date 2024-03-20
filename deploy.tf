terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.47.0"
    }
  }
}

provider "azuread" {
  tenant_id = ""

}

data "azuread_domains" "aad_domains" {}

output "domain_name" {
  value = data.azuread_domains.aad_domains.domains.0.domain_name
}

resource "azuread_group" "admins" {
  display_name     = "CA-Persona-Admins"
  security_enabled = true
}

resource "azuread_group" "sync" {
  display_name     = "CA-Persona-ADSyncAccount"
  security_enabled = true
}

resource "azuread_group" "break" {
  display_name     = "CA-Persona-BreakGlass"
  security_enabled = true
}

resource "azuread_group" "guest" {
  display_name     = "CA-Persona-GuestUsers"
  security_enabled = true
}

resource "azuread_group" "internal" {
  display_name     = "CA-Persona-Internals"
  security_enabled = true
}

output "admins_group_id" {
  value = azuread_group.admins.id
}

output "sync_group_id" {
  value = azuread_group.sync.id
}

output "break_group_id" {
  value = azuread_group.break.id
}

output "guest_group_id" {
  value = azuread_group.guest.id
}

output "internal_group_id" {
  value = azuread_group.internal.id
}

resource "azuread_user" "Panic" {
  display_name        = "Panic-Button-Provisioner"
  account_enabled     = false
  user_principal_name = "panic@${data.azuread_domains.aad_domains.domains.0.domain_name}"
  password = "notmyproblem"
}

resource "azuread_user" "All" {
  display_name        = "All-Access_Pass"
  account_enabled     = false
  user_principal_name = "all@${data.azuread_domains.aad_domains.domains.0.domain_name}"
  password = "notmyproblem"
}
