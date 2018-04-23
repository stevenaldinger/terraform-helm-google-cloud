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
