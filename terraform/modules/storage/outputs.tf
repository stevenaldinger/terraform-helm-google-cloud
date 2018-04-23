##############################
#    GCP STORAGE OUTPUTS     #
##############################

output "name" {
  value = "${google_storage_bucket.demo_app.name}"
}
