# Provider configuration
provider "google" {
  project = "astute-baton-430219-i9"
  region  = "us-central1"
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "portfolio-vpc"
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "portfolio-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc.id
}

# GKE cluster
resource "google_container_cluster" "primary" {
  name     = "portfolio-cluster"
  location = "us-central1"

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
  name       = "portfolio-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
  }
}

# Kubernetes provider
provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

# Static IP address
resource "google_compute_global_address" "portfolio_ip" {
  name = "portfolio-ip"
}

# Ingress
resource "kubernetes_ingress_v1" "portfolio" {
  metadata {
    name = "portfolio"
    annotations = {
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = google_compute_global_address.portfolio_ip.name
      "ingress.gcp.kubernetes.io/pre-shared-cert"   = "portfolio-ssl"
      "kubernetes.io/ingress.allow-http"            = "true"
      "ingress.gcp.kubernetes.io/force-ssl-redirect" = "true"
    }
  }

  spec {
    rule {
      host = "sparshramchandani.me"
      http {
        path {
          path = "/*"
          backend {
            service {
              name = "portfolio"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service_v1" "portfolio" {
  metadata {
    name = "portfolio"
  }

  spec {
    selector = {
      app = "portfolio"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "NodePort"
  }
}

# Deployment
resource "kubernetes_deployment_v1" "portfolio" {
  metadata {
    name = "portfolio"
    labels = {
      app = "portfolio"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "portfolio"
      }
    }

    template {
      metadata {
        labels = {
          app = "portfolio"
        }
      }

      spec {
        container {
          image = "us-central1-docker.pkg.dev/astute-baton-430219-i9/portfolio/app:latest"
          name  = "portfolio"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

# Google client configuration
data "google_client_config" "default" {}

# DNS Zone (assuming it already exists)
data "google_dns_managed_zone" "portfolio_zone" {
  name = "sparshramchandani"
}

# DNS A record
resource "google_dns_record_set" "portfolio" {
  name         = data.google_dns_managed_zone.portfolio_zone.dns_name
  managed_zone = data.google_dns_managed_zone.portfolio_zone.name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_global_address.portfolio_ip.address]
}