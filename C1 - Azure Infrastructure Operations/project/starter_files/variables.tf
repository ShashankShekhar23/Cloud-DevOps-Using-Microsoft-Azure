variable "prefix" {
  description = "The prefix which should be used for all resources"
}

variable "location" {
  description = "The Azure Region in which all resource should be created."
  default     = "East US"
}

variable "usr" {
  description = "The user name for the virtual machine that will be created."
}

variable "pwd" {
  description = "The password for the virtual machine that will be created."
}