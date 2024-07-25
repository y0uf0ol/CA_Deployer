terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.51.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.109.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = "tfsstate"
    key                  = ""
  }
}

provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.app_id
  client_secret = var.secret_id

}

resource "random_password" "password_panic" {
  length  = 16
  special = true
  lower   = true
  upper   = true
  numeric = true
}

resource "random_password" "password_break" {
  length  = 16
  special = true
  lower   = true
  upper   = true
  numeric = true
}