variable "tenant_id" {
  type        = string
  description = "Tenant ID "
  default     = ""
}

variable "app_id" {
  type        = string
  description = "Application ID"
  default     = ""
}

variable "secret_id" {
  type        = string
  description = "Secret ID"
  default     = ""
}

variable "features" {
  type        = bool
  description = "feature selection entra p1 or p2"
  default     = false
}

variable "trusted_ip" {
  type        = list(string)
  description = "add the of the Locations you want"
  default     = ["1.1.1.1", "1.0.0.1"]
}

variable "trusted_countries" {
  type        = string
  description = "Countries you trust or excpect logins from"
  default     = "DE,US"
}

variable "block_countries" {
  type        = list(string)
  description = "opposit of trusted"
  default     = ["RU"]
}
