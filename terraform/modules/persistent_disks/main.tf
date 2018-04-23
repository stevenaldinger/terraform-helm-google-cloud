####################################
#    GCP COMPUTE DISKS SETTINGS    #
####################################

resource "google_compute_disk" "vpn" {
  project = "${var.gcp_project}"
  name    = "${var.vpn_disk_name}"
  # "pd-standard"
  type    = "${var.vpn_disk_type}"
  zone    = "${var.gcp_zone}"
  size    = "10"
  labels {
    # thinking we might want to try encrypting the disk if sensitive later
    sensitive = "true"
  }
}
