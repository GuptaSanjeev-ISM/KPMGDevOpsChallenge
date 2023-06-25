## General variables
variable "location" {
  type = string
}
variable "region_code" {
  type        = string
  description = "region_code name. Use only lowercase letters and numbers"
}

variable "app_env" {
  type        = string
  description = "env name. Use only lowercase letters and numbers"
}

variable "app_name" {
  type        = string
  description = "proj_name or team name . Use only lowercase letters and numbers "
}

## Azure Environment Name

variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  #default = "dev"
}

variable "admin_password" {
  type      = string
  default   = null
  sensitive = true
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}


variable "vm_os_simple_1" {
  type    = string
  default = "UbuntuServer"
}

variable "vm_os_simple_2" {
  type    = string
  default = "Debian"
}

variable "vm" {
type = any
}