resource "azuread_conditional_access_policy" "ca200" {
  display_name = "CA200-Internals-BaseProtection-AllApps-AllPlatforms-MFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = []
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = []
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

resource "azuread_conditional_access_policy" "ca201" {
  display_name = "CA201-Internals-BaseProtection-AllApps-Windows-RequireComplianceDevice"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = []
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = []
      included_users  = []
      included_roles  = []
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

resource "azuread_conditional_access_policy" "ca202" {
  display_name = "CA202-Internals-BaseProtection-AllApps-Windows-RequireAADHJDevice"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = []
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = []
      included_users  = []
      included_roles  = []
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

resource "azuread_conditional_access_policy" "ca0203" {
  display_name = "CA203-Internals-BaseProtection-AllApps-MacOS-RequireComplianceDevice"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = []
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = []
      included_users  = []
      included_roles  = []
    }

    platforms {
      included_platforms = ["macOS"]
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

resource "azuread_conditional_access_policy" "ca204" {
  display_name = "CA204-Internals-DataProtection-AllApps-iOS-RequireAppProtection"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = []
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      included_users  = []
      included_roles  = []
    }

    platforms {
      included_platforms = ["iOS"]
      excluded_platforms = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["compliantApplication"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}

resource "azuread_conditional_access_policy" "ca205" {
  display_name = "CA205-Internals-DataProtection-AllApps-Android-RequireAppProtection"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = []
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      included_users  = []
      included_roles  = []
    }

    platforms {
      included_platforms = ["android"]
      excluded_platforms = []
    }
  }

  grant_controls {
    operator                      = "OR"
    built_in_controls             = ["compliantApplication"]
    custom_authentication_factors = []
    terms_of_use                  = []
  }
}


resource "azuread_conditional_access_policy" "ca206" {
  display_name = "CA206-Internals-DataProtection-AllApps-AllPlatforms-SignInFrequency"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
      excluded_applications = []
    }

    users {
      included_groups = []
      excluded_groups = []
      excluded_users  = []
      excluded_roles  = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
      included_users  = []
      included_roles  = []
    }
  }

  session_controls {
    sign_in_frequency_period = "days"
    sign_in_frequency        = 14

  }
}
