##############################
#    GCP PROJECT VARIABLES   #
##############################

variable "gcp_project" {
  type        = "string"
  description = "Unique project name for identifying the Google Cloud Project."
}
variable "gcp_zone" {
  type        = "string"
  description = "Zone to launch persistent disks in."
  default     = "us-east1-c"
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
