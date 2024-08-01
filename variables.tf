variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR range for the subnet"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "node_pool_name" {
  description = "The name of the GKE node pool"
  type        = string
}

variable "machine_type" {
  description = "The machine type for GKE nodes"
  type        = string
}

variable "static_ip_name" {
  description = "The name of the static IP address"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the portfolio"
  type        = string
}

variable "dns_zone_name" {
  description = "The name of the DNS zone"
  type        = string
}

variable "container_image" {
  description = "The container image for the portfolio application"
  type        = string
}
