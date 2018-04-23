##############################
#    GCP PROJECT VARIABLES   #
##############################

variable "gcp_project" {
  type        = "string"
  description = "Unique project name for identifying the Google Cloud Project."
}
variable "gcp_zone" {
  type        = "string"
  description = "The Google Cloud project target zone."
}

##############################
#    K8S CLUSTER VARIABLES   #
##############################

variable "cluster_name" {
  type        = "string"
  description = "The name of the cluster to provision."
}
variable "initial_node_count" {
  type        = "string"
  description = "The number of nodes to spin up in the cluster."
}
variable "kubernetes_version" {
  type        = "string"
  description = "The Kubernetes version to provision."
}
variable "kubernetes_node_machine_type" {
  type        = "string"
  description = "The Google compute machine type to provision."
}
variable "master_admin_username" {
  type        = "string"
  description = "The Kubernetes master admin username to create."
}
variable "master_admin_password" {
  type        = "string"
  description = "The Kubernetes master admin password to create."
}

##############################
#     GCP DISK VARIABLES     #
##############################

variable "vpn_disk_name" {
  type        = "string"
  description = "Name of disk that will persist VPN config."
}

##############################
#    GCP CLOUDSQL OUTPUTS    #
##############################

variable "demo_app_grpc_username" {
  type        = "string"
  description = "Demo App gRPC servers database username."
}
variable "demo_app_grpc_password" {
  type        = "string"
  description = "Demo App gRPC servers database password."
}
variable "demo_app_grpc_database_instance" {
  type        = "string"
  description = "Database instance Demo App gRPC server should connect to."
}
variable "demo_app_grpc_database_instance_region" {
  type        = "string"
  description = "Database instance region."
}
variable "demo_app_database_name" {
  type        = "string"
  description = "Database name."
}

variable "adminer_username" {
  type        = "string"
  description = "Adminer servers database username."
}
variable "adminer_password" {
  type        = "string"
  description = "Adminer servers database password."
}
variable "adminer_database_instance" {
  type        = "string"
  description = "Database instance Adminer server should connect to."
}

##############################
#       HELM VARIABLES       #
##############################

variable "demo_app_gui_image_tag" {
  type        = "string"
  description = "Demo App GUI image tag."
}

variable "demo_app_api_image_tag" {
  type        = "string"
  description = "Demo App API server image tag."
}

variable "demo_app_grpc_image_tag" {
  type        = "string"
  description = "Demo App gRPC server image tag."
}

variable "vpn_ip_address" {
  type        = "string"
  description = "VPN static IP address."
}

variable "nginx_ip_address" {
  type        = "string"
  description = "NGINX static IP address."
}

# variable "nginx_ip_address" {
#   type        = "string"
#   description = "NGINX static IP address."
# }

variable "vpn_config_file" {
  type        = "string"
  description = "Path to OpenVPN config file."
}
