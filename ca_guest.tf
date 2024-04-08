resource "azuread_conditional_access_policy" "ca400" {
  display_name = "CA400-Guests-BaseProtection-AllApps-AllPlatforms-MFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

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
    built_in_controls             = ["mfa"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca401" {
  display_name = "CA401-Guests-DataProtection-AllApps-AllPlatforms-SignInFrequency"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

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

  session_controls {
    sign_in_frequency_period = "days"
    sign_in_frequency        = 1
  }
}

resource "azuread_conditional_access_policy" "ca402" {
  display_name = "CA402-Guests-Compliance-AllApps-AllPlatforms-CombinedRegistration-RequireToU"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_user_actions = ["urn:user:registersecurityinfo"]
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
    built_in_controls             = []
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca403" {
  display_name = "CA403-Guests-AttackSurfaceReduction-AllApps_EXCP_O365Apps-AllPlatforms-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = ["2793995e-0a7d-40d7-bd35-6968ba142197", "Office365"]
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
