variable "tenant_id" {
  type = string
  description = "Tenant ID "
  default = ""
}

variable "app_id" {
  type = string
  description = "Application ID"
  default = ""
}

variable "secret_id" {
  type = string
  description = "Secret ID"
  default = ""
}

variable "features" {
  type = bool
  description = "feature selection entra p1 or p2"
  default = false 
}
