# Provider configuration
provider "google" {
  project = var.project_id
  region  = var.region
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.1.0.0/16"
    services_ipv4_cidr_block = "10.2.0.0/16"
  }
}

# GKE node pool
resource "google_container_node_pool" "primary_nodes" {
  name       = var.node_pool_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = var.machine_type
  }
}

# Google client configuration
data "google_client_config" "default" {}

# Kubernetes provider
provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

# Helm provider
provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.primary.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}

# Static IP address
resource "google_compute_global_address" "portfolio_ip" {
  name = var.static_ip_name
}

# Helm release
resource "helm_release" "portfolio" {
  name       = "portfolio"
  chart      = "./portfolio"  # Path to your Helm chart
  namespace  = "default"
  
  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.global-static-ip-name"
    value = google_compute_global_address.portfolio_ip.name
  }

  depends_on = [google_container_cluster.primary]
}

# DNS Zone (assuming it already exists)
data "google_dns_managed_zone" "portfolio_zone" {
  name = var.dns_zone_name
}

# DNS A record
resource "google_dns_record_set" "portfolio" {
  name         = data.google_dns_managed_zone.portfolio_zone.dns_name
  managed_zone = data.google_dns_managed_zone.portfolio_zone.name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_global_address.portfolio_ip.address]
}

# Null resource for cleanup
resource "null_resource" "delete_neg" {
  triggers = {
    cluster_name = google_container_cluster.primary.name
    project      = var.project_id
    region       = var.region
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
      gcloud container clusters get-credentials ${self.triggers.cluster_name} --region ${self.triggers.region} --project ${self.triggers.project}
      kubectl delete ingress portfolio
      sleep 60  # Wait for GCP to delete the NEG
    EOT
  }

  depends_on = [helm_release.portfolio]
}