resource "azuread_conditional_access_policy" "ca011" {
  display_name = "CA011-ADSyncAccount-AttackSurfaceReduction-AllApps-UnallowedNetworkLocationsAD-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_roles  = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      excluded_users  = []
      included_groups = []
      excluded_groups = []
      included_users  = []
      excluded_roles  = []
    }

    locations {
      included_locations = ["All"]
      excluded_locations = [azuread_named_location.trusted_location.id]
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["block"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca010" {
  display_name = "CA010-ADSyncAccount-AttackSurfaceReduction-AllApps-UnallowedPaltforms-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_roles  = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      excluded_users  = []
      included_groups = []
      excluded_groups = []
      included_users  = []
      excluded_roles  = []
    }

    platforms {
      included_platforms = ["all"]
      excluded_platforms = ["windows"]
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["block"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}
