variable "POSTGRES_PASSWORD" {
  description = "POSTGRES PASSWORD id"
  type        = string
}

variable "POSTGRES_USER" {
  description = "POSTGRES USER"
  type        = string
}

variable "POSTGRES_DB" {
  description = "POSTGRES DB"
  type        = string
}

resource "docker_container" "redis" {
  name    = "redis"
  image   = docker_image.redis.name
  restart = "always"
  ports {
    external = 6379
    internal = 6379
  }
  networks_advanced {
    name = docker_network.back-tier.name
  }
}

resource "docker_container" "db" {
  name  = "db"
  image = docker_image.db.name
  volumes {
    container_path = "/var/lib/postgresql/data"
    volume_name    = docker_volume.db-data.name
  }
  env = [
    "POSTGRES_PASSWORD=${var.POSTGRES_PASSWORD}",
    "POSTGRES_USER=${var.POSTGRES_USER}",
    "POSTGRES_DB=${var.POSTGRES_DB}"
  ]
  ports {
    internal = 5432
    external = 5432
  }
  networks_advanced {
    name = docker_network.back-tier.name
  }
}

resource "docker_container" "worker" {
  name       = "worker"
  image      = docker_image.worker.name
  depends_on = [docker_container.db, docker_container.redis]
  networks_advanced {
    name = docker_network.back-tier.name
  }
}

resource "docker_container" "vote-1" {
  name       = "vote-1"
  image      = docker_image.vote.name
  depends_on = [docker_container.redis]
  ports {
    external = 5001
    internal = 5000
  }
  networks_advanced {
    name = docker_network.back-tier.name
  }
  networks_advanced {
    name = docker_network.front-tier.name
  }
}

resource "docker_container" "vote-2" {
  name       = "vote-2"
  image      = docker_image.vote.name
  depends_on = [docker_container.redis]
  ports {
    external = 5002
    internal = 5000
  }
  networks_advanced {
    name = docker_network.back-tier.name
  }
  networks_advanced {
    name = docker_network.front-tier.name
  }
}

resource "docker_container" "seed" {
  name       = "seed"
  image      = docker_image.seed.name
  depends_on = [docker_container.nginx]
  networks_advanced {
    name = docker_network.front-tier.name
  }
}

resource "docker_container" "result" {
  name       = "result"
  image      = docker_image.result.name
  depends_on = [docker_container.db]
  ports {
    internal = 4000
    external = 4000
  }
  networks_advanced {
    name = docker_network.front-tier.name
  }
  networks_advanced {
    name = docker_network.back-tier.name
  }
}

resource "docker_container" "nginx" {
  name       = "vote-loadbalancer"
  image      = docker_image.nginx.name
  depends_on = [docker_container.vote-1, docker_container.vote-2]
  ports {
    internal = 5000
    external = 5000
  }
  networks_advanced {
    name = docker_network.front-tier.name
  }
}
