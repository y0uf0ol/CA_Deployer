terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.15.0"
    }
  }
}

provider "azuread" {
  tenant_id = ""

}


resource "azuread_conditional_access_policy" "example" {
  display_name = "CA010-ADSyncAccount-AttackSurfaceReduction-AllApps-UnallowedPaltforms-Block"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }
    locations {
      included_locations = ["All"]
    }


    users {
      included_roles = ["d29b2b05-8046-44ba-8758-1e26182fcf32"]
    }

    platforms {
      included_platforms = ["all"]
      excluded_platforms = ["windows"]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
