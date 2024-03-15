terraform {
required_providers {
google = {
source = "hashicorp/google"
}
}
}

provider "google" {
region = "us-central1"
zone = "us-central1-c"
}

resource "random_id" "random_suffix" {
  byte_length = 5
}


resource "google_compute_network" "acme_network"{
name = "acme-network-1"
delete_default_routes_on_create = false
auto_create_subnetworks = false
routing_mode = "REGIONAL"
mtu = 1000
# project = "XXXXXXX"
}

resource "google_container_node_pool" "acme_node_pool" {
name = "acme-node-pool-1"
cluster = "acme-cluster-1"
# project = "XXXXXXX"
initial_node_count = 3
node_config {
preemptible = true
machine_type = "e2-medium"
}
}

resource "google_storage_bucket" "acme_bucket" {
name = "acme-bucket-1-${random_id.random_suffix.hex}"
location = "US"
force_destroy = true
# project = "XXXXXXX"
uniform_bucket_level_access = true
logging {
log_bucket = "my-unique-logging-bucket-${random_id.random_suffix.hex}"
log_object_prefix = "tf-logs/"
}
}