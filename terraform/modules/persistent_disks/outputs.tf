##############################
#    GCP STORAGE OUTPUTS     #
##############################

output "name" {
  value = "${google_compute_disk.vpn.name}"
}
