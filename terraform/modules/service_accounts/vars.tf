##############################
#    GCP PROJECT VARIABLES   #
##############################

variable "gcp_project" {
  type        = "string"
  description = "Unique project name for identifying the Google Cloud Project."
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
