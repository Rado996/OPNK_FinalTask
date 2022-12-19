# --- root/variables.tf ---

variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "tenant_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "flavor_name" {
  type = string
  default = "TEST"
}