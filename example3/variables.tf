variable "environment" {
  description = "Name of the environment (e.g. dev, test, prod)."
  type        = string
}

variable "short_location_code" {
  description = "A short form of the location where resource are deployed, used in naming conventions."
  type        = string
}

variable "location" {
  description = "Location where resources are deployed."
  type        = string
}
