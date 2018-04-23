##############################
#      GCP IAM VARIABLES     #
##############################

variable "gcp_project" {
  type        = "string"
  description = "Unique project name for identifying the Google Cloud Project."
}
variable "demo_app_grpc_email" {
  type        = "string"
  description = "Email address of Demo App gRPC server's service account."
}
variable "adminer_email" {
  type        = "string"
  description = "Email address of Adminer server's service account."
}
