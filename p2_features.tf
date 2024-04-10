resource "azuread_conditional_access_policy" "ca108" {
  count        = var.features ? 1 : 0
  display_name = "CA108-Admins-IdentityProtection-AllApps-AllPlatforms-MediumSignInRisk_OR_MediumUserRisk-PhishingResistantMFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    user_risk_levels    = ["medium"]
    sign_in_risk_levels = ["medium"]
    client_app_types    = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = []
      included_roles  = []
      excluded_roles  = []
    }
  }

  grant_controls {
    operator                          = "OR"
    authentication_strength_policy_id = azuread_authentication_strength_policy.Custom_Phish.id

  }
}


resource "azuread_conditional_access_policy" "ca109" {
  count        = var.features ? 1 : 0
  display_name = "CA109-Admins-IdentityProtection-AllApps-AllPlatforms-HighSignInRisk_OR_HighUserRisk-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    user_risk_levels    = ["high"]
    sign_in_risk_levels = ["high"]
    client_app_types    = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = []
      included_roles  = []
      excluded_roles  = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["block"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca207" {
  count        = var.features ? 1 : 0
  display_name = "CA207-Internals-IdentityProtection-AllApps-AllPlatforms-MediumSignInRisk_OR_MediumUserRisk-MFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    user_risk_levels    = ["medium"]
    sign_in_risk_levels = ["medium"]
    client_app_types    = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.internal.id]
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      included_users  = []
      included_roles  = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["mfa"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca208" {
  count        = var.features ? 1 : 0
  display_name = "CA208-Internals-IdentityProtection-AllApps-AllPlatforms-HighSignInRisk_MFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    sign_in_risk_levels = ["high"]
    client_app_types    = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.internal.id]
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      included_users  = []
      included_roles  = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["mfa"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca209" {
  display_name = "CA209-Internals-IdentityProtection-AllApps-AllPlatforms-HighUserRisk_MFA_AND_ChangePWD"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    user_risk_levels = ["high"]
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.internal.id]
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      included_users  = []
      included_roles  = []
    }
  }

  grant_controls {
    operator                      = "AND"
    built_in_controls             = ["mfa", "passwordChange"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "example" {
  count        = var.features ? 1 : 0
  display_name = "CA404-Guests-IdentityProtection-AllApps-AllPlatforms-HighSignInRisk_OR_HighUserRisk-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    user_risk_levels    = ["high"]
    sign_in_risk_levels = ["high"]
    client_app_types    = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.guest.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = []
      included_roles  = []
      excluded_roles  = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["block"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}
