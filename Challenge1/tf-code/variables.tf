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