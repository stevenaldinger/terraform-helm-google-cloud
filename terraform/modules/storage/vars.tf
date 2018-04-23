##############################
#    GCP PROJECT VARIABLES   #
##############################

variable "gcp_project" {
  type        = "string"
  description = "Unique project name for identifying the Google Cloud Project."
}

##############################
#    GCP BUCKET VARIABLES    #
##############################

variable "bucket_name_demo_app" {
  type        = "string"
  description = "Demo App storage bucket."
}
variable "bucket_location_demo_app" {
  type        = "string"
  description = "Demo App storage bucket target region."
  default     = "us-east1"
}
variable "bucket_class_demo_app" {
  type        = "string"
  description = "Demo App storage bucket target class."
  default     = "MULTI_REGIONAL"
}
