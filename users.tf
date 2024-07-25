data "azuread_user" "break_1_exists" {
  user_principal_name = "panic@${data.azuread_domains.aad_domains.domains.0.domain_name}"
}

data "azuread_user" "break_2_exists" {
  user_principal_name = "all@${data.azuread_domains.aad_domains.domains.0.domain_name}"
}


resource "azuread_user" "Panic" {
  count               = data.azuread_user.break_1_exists.user_principal_name != null ? 1 : 0
  display_name        = "Break-Panic-Button-Provisioner"
  account_enabled     = false
  user_principal_name = "panic@${data.azuread_domains.aad_domains.domains.0.domain_name}"
  password            = random_password.password_panic.result
}

resource "azuread_user" "All" {
  count               = data.azuread_user.break_2_exists.user_principal_name != null ? 1 : 0
  display_name        = "Break-All-Access_Pass"
  account_enabled     = false
  user_principal_name = "all@${data.azuread_domains.aad_domains.domains.0.domain_name}"
  password            = random_password.password_break.result
}


resource "azuread_authentication_strength_policy" "Custom_Phish" {
  #count = data.azuread_authentication_strength_policy.Custom_Phish ? 0 : 1
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

output "password_panic" {
  value     = random_password.password_panic.result
  sensitive = true
}

output "password_break" {
  value     = random_password.password_break.result
  sensitive = true
}