variable "project_id" {
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  region = "us-central1"
  zone   = "us-central1-c"
}
resource "google_compute_network" "acme_network" {
  name                            = "acme-network-1"
  delete_default_routes_on_create = false
  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
  mtu                             = 100
}

resource "google_container_node_pool" "acme_node_pool" {
  name    = "acme-node-pool-1"
  cluster = "acme-cluster-1"
  #project = "sccp-preview-proj"
  initial_node_count = 2
  node_config {
    preemptible  = true
    machine_type = "e2-medium"
  }
}


resource "google_storage_bucket" "acme_bucket" {
  name                        = "acme-bucket-1"
  location                    = "EU"
  force_destroy               = true
  project                     = var.project_id
  uniform_bucket_level_access = false
}
