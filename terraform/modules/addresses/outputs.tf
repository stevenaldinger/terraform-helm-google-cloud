##############################
#    GCP ADDRESSES OUTPUTS   #
##############################

output vpn_static_address_name {
  value = "${google_compute_address.vpn.address}"
}
output nginx_static_address_name {
  value = "${google_compute_address.nginx.address}"
}

# output vpn_static_address_name {
#   value = "${google_compute_global_address.vpn.address}"
# }

# output nginx_static_address_name {
#   value = "${google_compute_global_address.nginx.address}"
# }
