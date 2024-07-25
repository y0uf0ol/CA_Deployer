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

variable "admin_schema" {
  type        = string
  description = "name schema for admin accounts to fill group e.g. adm_"
  default     = "adm-"
}

variable "trusted_ip" {
  type        = list(string)
  description = "add the of the Locations you want"
  default     = ["192.168.65.1/32"]
}

variable "trusted_countries" {
  type        = list(string)
  description = "Countries you trust or excpect logins from"
  default     = ["DE"]
}

variable "block_countries" {
  type        = list(string)
  description = "opposit of trusted"
  default     = ["RU"]
}



# IF Exists check Breakglass und Authentication Policy
variable "break_1_exists" {
  type    = string
  default = "Break-Panic-Button-Provisioner"
}

variable "break_2_exists" {
  type    = string
  default = "Break-All-Access_Pass"
}

variable "auth_meth_exists" {
  type    = string
  default = "Custom Phishing-resistant"
}