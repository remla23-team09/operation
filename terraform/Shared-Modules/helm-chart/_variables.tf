
variable "name" {
  description = "Name of the customer"
  type = string
}

variable "repository" {
  description = "Helm repository URL"
  type = string
}

variable "chart" {
  description = "Helm chart to deploy"
  type = string
}

variable "chart_version" {
  description = "Version of the helm chart to deploy"
  type = string
}

variable "namespace" {
  description = "Namespace to deploy the chart"
  type = string
}

variable "wait" {
  description = "Add wait counter"
  type = bool
  default = true
}

variable "timeout" {
  description = "Add timeout counter"
  type = number
  default = 600
}

variable "values" {
  description = "Value files to apply"
  type = list
  default = []
}

variable "set_maps" {
  description = "Set variable name"
  type = map
  default = {}
}