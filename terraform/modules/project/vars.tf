##############################
#    GCP PROJECT VARIABLES   #
##############################

variable "gcp_project" {
  type        = "string"
  description = "Unique project name for identifying the Google Cloud Project."
}
variable "gcp_region" {
  type        = "string"
  description = "The target Google Cloud region for deployments."
  default     = "us-east1"
}
# directly referencing the account id was throwing off Terraform's ability to link dependencies and breaking scripts
# variable "gcp_billing_account" {
#     type ="string"
#     description = "The billing account to link to the new Google Cloud project."
# }
variable "gcp_billing_account_display_name" {
  # https://console.cloud.google.com/billing/projects?folder&supportedpurview=project
  type        = "string"
  description = "The billing account's 'display name' to link to the new Google Cloud project."
  default     = "My Billing Account"
}
variable "gcp_organization_id" {
  type        = "string"
  description = "The unique Organization ID to link to the new Google Cloud project."
}
