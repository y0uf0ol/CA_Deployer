resource "azuread_conditional_access_policy" "ca100" {
  display_name = "CA100-Admins-BaseProtection-AllApps-AllPlatforms-PhishingResistantMFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = [azuread_group.break.id]
      included_roles  = []
      excluded_roles  = []
    }
  }

  grant_controls {
    operator                          = "OR"
    authentication_strength_policy_id = azuread_authentication_strength_policy.Custom_Phish.id
  }
}


resource "azuread_conditional_access_policy" "ca101" {
  display_name = "CA101-Admins-BaseProtection-AllApps-Windows-RequireComplianceDevice"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = [azuread_group.break.id]
      included_roles  = []
      excluded_roles  = []
    }

    platforms {
      included_platforms = ["windows"]
      excluded_platforms = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["compliantDevice"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca102" {
  display_name = "CA102-Admins-BaseProtection-AllApps-Windows-RequireAADHJDevice"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = [azuread_group.break.id]
      included_roles  = []
      excluded_roles  = []
    }

    platforms {
      included_platforms = ["windows"]
      excluded_platforms = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["domainJoinedDevice"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca103" {
  display_name = "CA103-Admins-DataProtection-AllApps-AllPlatforms-SignInFrequency_AND_NerverPersistantSession"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = [azuread_group.break.id]
      included_roles  = []
      excluded_roles  = []
    }
  }

  session_controls {
    sign_in_frequency_period = "hours"
    sign_in_frequency        = 4
    persistent_browser_mode  = "never"
  }
}

resource "azuread_conditional_access_policy" "ca104" {
  display_name = "CA104-Admins-AttackSurfaceReduction-AllApps-iOS-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = [azuread_group.break.id]
      included_roles  = []
      excluded_roles  = []
    }

    platforms {
      included_platforms = ["iOS"]
      excluded_platforms = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["block"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca105" {
  display_name = "CA105-Admins-AttackSurfaceReduction-AllApps-Android-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = [azuread_group.break.id]
      included_roles  = []
      excluded_roles  = []
    }

    platforms {
      included_platforms = ["android"]
      excluded_platforms = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["block"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca106" {
  display_name = "CA106-Admins-AttackSurfaceReduction-AllApps-MacOS-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = [azuread_group.admins.id]
      excluded_users  = []
      included_users  = []
      excluded_groups = [azuread_group.break.id]
      included_roles  = []
      excluded_roles  = []
    }

    platforms {
      included_platforms = ["macOS"]
      excluded_platforms = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["block"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}
