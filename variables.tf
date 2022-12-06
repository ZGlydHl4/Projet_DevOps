variable "resource_group_location" {
  default     = "francecentral"
  description = "Location of the resource group."
}

variable "application_port" {
  description = "Port that you want to expose to the external load balancer"
  default     = 80
}
