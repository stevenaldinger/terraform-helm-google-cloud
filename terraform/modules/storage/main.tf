##############################
#    GCP STORAGE SETTINGS    #
##############################

resource "google_storage_bucket" "demo_app" {
  project       = "${var.gcp_project}"
  name          = "${var.bucket_name_demo_app}"
  location      = "${var.bucket_location_demo_app}"
  storage_class = "${var.bucket_class_demo_app}"
}
