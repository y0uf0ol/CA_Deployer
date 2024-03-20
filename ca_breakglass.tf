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

resource "azuread_conditional_access_policy" "break1" {
  display_name = "CA001-BreakGlas01-BaseProtection-AllApps-AllPlatforms-PhishingResistantMFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["all"]
    }

    users {
      included_groups = [azuread_group.break.id]
    }
    locations {
      included_locations = ["all"]
    }
    platforms {
      included_platforms = ["all"]
    }


  }
  grant_controls {
    operator                          = "OR"
    authentication_strength_policy_id = azuread_authentication_strength_policy.Custom_Phish.id


  }
}

resource "azuread_conditional_access_policy" "break2" {
  display_name = "CA002-BreakGlas02-BaseProtection-AllApps-AllPlatforms-PhishingResistantMFA"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["all"]
    }

    users {
      included_groups = [azuread_group.break.id]
    }

    locations {
      included_locations = ["all"]
    }
    platforms {
      included_platforms = ["all"]
    }
  }

  grant_controls {
    operator                          = "OR"
    authentication_strength_policy_id = azuread_authentication_strength_policy.Custom_Phish.id
  }
}
