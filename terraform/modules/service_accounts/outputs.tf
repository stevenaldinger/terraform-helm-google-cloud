######################################
#    GCP SERVICE ACCOUNTS OUTPUTS    #
######################################

output demo_app_grpc_unique_id {
  value = "${google_service_account.demo_app_grpc.unique_id}"
}

output demo_app_grpc_name {
  value = "${google_service_account.demo_app_grpc.name}"
}

output demo_app_grpc_email {
  value = "${google_service_account.demo_app_grpc.email}"
}

output demo_app_grpc_public_key {
  value = "${google_service_account_key.demo_app_grpc_key.public_key}"
}

output demo_app_grpc_private_key {
  value = "${google_service_account_key.demo_app_grpc_key.private_key}"
}

output adminer_unique_id {
  value = "${google_service_account.adminer.unique_id}"
}

output adminer_name {
  value = "${google_service_account.adminer.name}"
}

output adminer_email {
  value = "${google_service_account.adminer.email}"
}

output adminer_public_key {
  value = "${google_service_account_key.adminer_key.public_key}"
}

output adminer_private_key {
  value = "${google_service_account_key.adminer_key.private_key}"
}
