terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.47.0"
    }
  }
}

provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.app_id
  client_secret = var.secret_id

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
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.displayName -startsWith \"On-Premises\""

  }
}

resource "azuread_group" "break" {
  display_name     = "CA-Persona-BreakGlass"
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.displayName -startsWith \"Break\""
  }
}

resource "azuread_group" "guest" {
  display_name     = "CA-Persona-GuestUsers"
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.userType - eq \"Guest\""
  }
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
  display_name        = "Break-Panic-Button-Provisioner"
  account_enabled     = false
  user_principal_name = "panic@${data.azuread_domains.aad_domains.domains.0.domain_name}"
  password            = "notmyproblem123!!!!"
}

resource "azuread_user" "All" {
  display_name        = "Break-All-Access_Pass"
  account_enabled     = false
  user_principal_name = "all@${data.azuread_domains.aad_domains.domains.0.domain_name}"
  password            = "notmyproblem1234!!!!!!"
}


resource "azuread_authentication_strength_policy" "Custom_Phish" {
  display_name = "Custom Phishing-resistant"
  description  = "Generated Phis Resist Pol"
  allowed_combinations = [
    "fido2",
    "temporaryAccessPassOneTime",
  ]
}

output "phish_resist_id" {
  value = azuread_authentication_strength_policy.Custom_Phish.id
}
