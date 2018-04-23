##############################
#    GCP PROJECT VARIABLES   #
##############################

variable "gcp_project" {
  type        = "string"
  description = "Unique project name for identifying the Google Cloud Project."
}
variable "gcp_region" {
  type        = "string"
  description = "The Google Cloud project target region."
}

##############################
#   GCP CLOUDSQL VARIABLES   #
##############################

variable "cloudsql_database_instance_name" {
  type        = "string"
  description = "Unique database instance name for identifying the CloudSQL instance."
}
variable "cloudsql_database_instance_version" {
  type        = "string"
  description = "The target MySQL version to provision."
}
variable "cloudsql_database_instance_machine_type" {
  type        = "string"
  description = "The machine type to run the database instance on."
}
variable "cloudsql_database_name" {
  type        = "string"
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
