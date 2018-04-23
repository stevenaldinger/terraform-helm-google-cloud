###############################
#    GCP ADDRESSES SETTINGS   #
###############################

resource "google_compute_address" "vpn" {
  name = "${var.vpn_static_address_name}"
  project = "${var.gcp_project}"
  region = "${var.gcp_region}"
}

resource "google_compute_address" "nginx" {
  name = "${var.nginx_static_address_name}"
  project = "${var.gcp_project}"
  region = "${var.gcp_region}"
}

# resource "google_compute_global_address" "vpn" {
#   name = "${var.vpn_static_address_name}"
#   project = "${var.gcp_project}"
# }

# resource "google_compute_global_address" "nginx" {
#   name = "${var.nginx_static_address_name}"
#   project = "${var.gcp_project}"
# }
