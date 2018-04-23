##############################
#    GCP PROJECT SETTINGS    #
##############################

provider "google" {
  region = "${var.gcp_region}"
}

data "google_billing_account" "acct" {
  display_name = "${var.gcp_billing_account_display_name}"
  open         = true
}

resource "google_project" "project" {
  # Your project name must unique!!
  name            = "${var.gcp_project}"
  project_id      = "${var.gcp_project}"
  # billing_account = "${var.gcp_billing_account}"
  billing_account = "${data.google_billing_account.acct.id}"
  org_id          = "${var.gcp_organization_id}"
}

# be careful removing any of these. certain services are
# created as dependencies of one's explicitly listed
# and when terraform is applied the second time it removes
# services google had created that it didn't realize it needs
resource "google_project_services" "project_services" {
  project   = "${google_project.project.project_id}"
  services  = [
    "bigquery-json.googleapis.com",
    "cloudapis.googleapis.com",
    "cloudbuild.googleapis.com",
    "clouddebugger.googleapis.com",
    "cloudtrace.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "dns.googleapis.com",
    "deploymentmanager.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "plus.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "resourceviews.googleapis.com",
    "replicapool.googleapis.com",
    "replicapoolupdater.googleapis.com",
    "sqladmin.googleapis.com",
    "servicecontrol.googleapis.com",
    "servicemanagement.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "sql-component.googleapis.com",
    "datastore.googleapis.com"
  ]

  # wait a few minutes for apis to enable
  provisioner "local-exec" {
    command = "sleep 60"
  }
}
