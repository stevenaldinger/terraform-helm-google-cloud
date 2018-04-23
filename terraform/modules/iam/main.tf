##############################
#      GCP IAM SETTINGS      #
##############################

resource "google_project_iam_member" "stevenaldinger" {
  project = "${var.gcp_project}"
  role    = "roles/owner"
  member  = "user:stevenaldinger@gmail.com"
}
resource "google_project_iam_member" "demo_app_grpc" {
  project = "${var.gcp_project}"
  role    = "roles/cloudsql.editor"
  member  = "serviceAccount:${var.demo_app_grpc_email}"
}
resource "google_project_iam_member" "adminer" {
  project = "${var.gcp_project}"
  role    = "roles/cloudsql.editor"
  member  = "serviceAccount:${var.adminer_email}"
}
