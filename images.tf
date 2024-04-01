locals {
  TARGETPLATFORM = "linux/amd64"
  TARGETARCH     = "amd64"
  BUILDPLATFORM  = "linux/amd64"
}

resource "docker_image" "redis" {
  name = "redis:7-alpine"
}

resource "docker_image" "db" {
  name = "postgres:16-alpine"
}

resource "docker_image" "worker" {
  name = "${var.artifact_registry_url}/worker"
  build {
    context = "./worker/"
    build_arg = {
      TARGETPLATFORM : local.TARGETPLATFORM
      TARGETARCH : local.TARGETARCH
      BUILDPLATFORM : local.BUILDPLATFORM
    }
  }
}

resource "docker_image" "vote" {
  name = "${var.artifact_registry_url}/vote"
  build {
    context = "./vote/"
  }
}

resource "docker_image" "seed" {
  name = "${var.artifact_registry_url}/seed"
  build {
    context = "./seed-data/"
  }
}

resource "docker_image" "result" {
  name = "${var.artifact_registry_url}/result"
  build {
    context = "./result/"
  }
}

resource "docker_image" "nginx" {
  name = "nginx"
  build {
    context = "./nginx"
  }
}
