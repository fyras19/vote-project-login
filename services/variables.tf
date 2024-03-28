variable "metadata_name" {
  type = string
}

variable "label_app" {
  type = string
}

variable "service_type" {
  type = string
}

variable "service_ports" {
  type = object({
    port       = number
    targetPort = number
  })
}
