data "azuread_domains" "aad_domains" {}

output "domain_name" {
  value = data.azuread_domains.aad_domains.domains.0.domain_name
}

resource "azuread_group" "admins" {
  display_name     = "CA-Persona-Admins"
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.userPrincipalName -startsWith \"${var.admin_schema}\" "

  }
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
    rule    = "user.userType -eq \"Guest\""
  }
}

resource "azuread_group" "internal" {
  display_name     = "CA-Persona-Internals"
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.userType -ne \"Guest\" -or user.userPrincipalName -startsWith \"${var.admin_schema}\" -or user.displayName -startsWith \"Break\""
  }
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