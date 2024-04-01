variable "metadata_name" {
  type = string
}

variable "label_app" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "number_of_replicas" {
  type = number
}

variable "env_variables" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "volume_mounts" {
  type = list(object({
    name      = string
    subPath   = string
    mountPath = string
  }))
  default = []
}

variable "volumes" {
  type = list(object({
    name = string
    persistentVolumeClaim = object({
      claimName = string
    })
  }))
  default = []
}
