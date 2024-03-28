variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
  default = "us-central1"
}

variable "zone" {
  description = "zone"
  default = "us-central1-c"
}

variable "docker_host" {
  description = "The Docker host address"
  default     = "unix:///var/run/docker.sock"
}

variable "target_service_account" {
  type        = string
  description = "target service account of default compute engine service account"
}

variable "credentials_filename" {
  type = string
}

variable "artifact_registry_url" {
  type = string
  description = "The URL of the GCP artifact registry where the images will be pushed"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.23.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file(var.credentials_filename)
}

# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
data "google_client_config" "default" {}

provider "kubernetes" {
  host  = "https://${google_container_cluster.mycluster.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.mycluster.master_auth[0].cluster_ca_certificate,
  )
}

provider "docker" {
  host = var.docker_host
  registry_auth {
    address  = "europe-west9-docker.pkg.dev"
    username = "oauth2accesstoken"
    password = data.google_service_account_access_token.sa.access_token
  }
}

data "google_service_account_access_token" "sa" {
  target_service_account = var.target_service_account
  scopes                 = ["cloud-platform"]
}
