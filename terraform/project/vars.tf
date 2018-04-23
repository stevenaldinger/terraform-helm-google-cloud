#######################################
#   Demo App PROJECT VARIABLES   #
#######################################

variable "env" {
  type        = "string"
  description = "Target environment name... will currently create a new project named '${gcp_project}-${env}'."
  default = "development"
}
variable "gcp_project" {
  type        = "string"
  description = "Unique project name for identifying the Google Cloud Project."
}
variable "gcp_region" {
  type = "string"
  description = "The target Google Cloud region for deployments."
  default = "us-east1"
}
variable "gcp_zone" {
  type = "string"
  description = "The target Google Cloud zone for deployments."
  default = "us-east1-c"
}
# referring to this directly was breaking Terraforms ability to link module dependencies
# variable "gcp_billing_account" {
#     type = "string"
#     description = "The billing account to link to the new Google Cloud project."
# }
variable "gcp_billing_account_display_name" {
  type = "string"
  description = "The billing account to link to the new Google Cloud project."
}
variable "gcp_organization_id" {
  type = "string"
  description = "The unique Organization ID to link to the new Google Cloud project."
}

#######################################
#    GCP SERVICE ACCOUNTS VARIABLES   #
#######################################

variable "demo_app_grpc_name" {
  type        = "string"
  description = "Unique ID of Demo App gRPC server service account."
}
variable "demo_app_grpc_display_name" {
  type        = "string"
  description = "The display name of Demo App gRPC server service account."
  default     = "Demo App gRPC Server"
}
variable "adminer_name" {
  type        = "string"
  description = "Unique ID of Adminer server service account."
}
variable "adminer_display_name" {
  type        = "string"
  description = "The display name of Adminer server service account."
  default     = "Adminer Server"
}

##############################
#     CLOUDSQL VARIABLES     #
##############################

variable "cloudsql_database_instance_name" {
  type        = "string"
  description = "Unique database instance name for identifying the CloudSQL instance."
}
variable "cloudsql_database_instance_version" {
  type = "string"
  description = "The target MySQL version to provision."
}
variable "cloudsql_database_instance_machine_type" {
  type = "string"
  description = "The machine type to run the database instance on."
}
variable "cloudsql_database_name" {
  type = "string"
  description = "The name of the database that will be created."
}
variable "cloudsql_user_demo_app_grpc" {
  type        = "string"
  description = "User for GRPC server to be created and granted privileges to the database."
}
variable "cloudsql_password_demo_app_grpc" {
  type        = "string"
  description = "Password to use to connect with 'cloudsql_user_demo_app_grpc' (see above)."
}
variable "cloudsql_user_adminer" {
  type        = "string"
  description = "User for Adminer server to be created and granted privileges to the database."
}
variable "cloudsql_password_adminer" {
  type        = "string"
  description = "Password to use to connect with 'cloudsql_user_adminer' (see above)."
}

######################################
#    GCP STORAGE BUCKET VARIABLES    #
######################################

variable "bucket_name_demo_app" {
  type        = "string"
  description = "Demo App storage bucket."
}
variable "bucket_location_demo_app" {
  type = "string"
  description = "Demo App storage bucket target region."
  default = "us-east1"
}
variable "bucket_class_demo_app" {
  type = "string"
  description = "Demo App storage bucket target class."
  default = "MULTI_REGIONAL"
}

##############################
#     GCP DISK VARIABLES     #
##############################

variable "vpn_disk_name" {
  type        = "string"
  description = "Name of disk that will persist VPN config."
}
variable "vpn_disk_type" {
  type        = "string"
  description = "Type of disk (ssd, hdd) from 'gcloud compute disk-types list'."
  default     = "pd-standard"
}
variable "vpn_disk_size" {
  type        = "string"
  description = "Size of disk in GB."
  default     = "10"
}

###############################
#   GCP ADDRESSES VARIABLES   #
###############################

variable "vpn_static_address_name" {
  type        = "string"
  description = "VPN static address unique name."
}
variable "nginx_static_address_name" {
  type        = "string"
  description = "NGINX static address unique name."
}

##############################
#    K8S CLUSTER VARIABLES   #
##############################

variable "cluster_name" {
  type = "string"
  description = "The name of the cluster to provision."
}
variable "initial_node_count" {
  type = "string"
  description = "The number of nodes to spin up in the cluster."
}
variable "kubernetes_version" {
  type = "string"
  description = "The Kubernetes version to provision."
}
variable "kubernetes_node_machine_type" {
  type = "string"
  description = "The Google compute machine type to provision."
}
variable "master_admin_username" {
  type = "string"
  description = "The Kubernetes master admin username to create."
}
variable "master_admin_password" {
  type = "string"
  description = "The Kubernetes master admin password to create."
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
  description = "Demo App API image tag."
}
variable "demo_app_grpc_image_tag" {
  type        = "string"
  description = "Demo App gRPC image tag."
}
