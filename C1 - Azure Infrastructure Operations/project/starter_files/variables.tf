variable "prefix" {
  description = "The prefix which should be used for all resources"
  default     = "project"
}

variable "location" {
  description = "The Azure Region in which all resource should be created."
  default     = "East US"
}

variable "number" {
  description = "The count of resources that should be created."
  default     = "2"
}

variable "tags" {
  description = "The tags which will be assigned to the resource created."
  default     = {
       Project_Name = "Deploying a Web Server in Azure"
       Category         = "Web Server"
}
}

variable "usr" {
  description = "The user name for the virtual machine that will be created."
  default     = "adminuser"
}

variable "pwd" {
  description = "The password for the virtual machine that will be created."
  default     = "Password@1234"
}
