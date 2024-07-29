# variables.tf

variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
  default     = "astute-baton-430219-i9"
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "portfolio-vpc"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "portfolio-subnet"
}

variable "subnet_cidr" {
  description = "The CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "portfolio-cluster"
}

variable "node_pool_name" {
  description = "The name of the GKE node pool"
  type        = string
  default     = "portfolio-node-pool"
}

variable "machine_type" {
  description = "The machine type for GKE nodes"
  type        = string
  default     = "e2-medium"
}

variable "static_ip_name" {
  description = "The name of the static IP address"
  type        = string
  default     = "portfolio-ip"
}

variable "domain_name" {
  description = "The domain name for the portfolio"
  type        = string
  default     = "sparshramchandani.me"
}

variable "dns_zone_name" {
  description = "The name of the DNS zone"
  type        = string
  default     = "sparshramchandani"
}

variable "container_image" {
  description = "The container image for the portfolio application"
  type        = string
  default     = "us-central1-docker.pkg.dev/astute-baton-430219-i9/portfolio/app:latest"
}