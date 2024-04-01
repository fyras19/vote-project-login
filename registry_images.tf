resource "docker_registry_image" "result" {
  name          = docker_image.result.name
  keep_remotely = true
}

resource "docker_registry_image" "seed" {
  name          = docker_image.seed.name
  keep_remotely = true
}

resource "docker_registry_image" "vote" {
  name          = docker_image.vote.name
  keep_remotely = true
}

resource "docker_registry_image" "worker" {
  name          = docker_image.worker.name
  keep_remotely = true
}
