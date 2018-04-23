##############################
#    GCP CLOUDSQL OUTPUTS    #
##############################

output instance_address {
  value = "${google_sql_database_instance.demo_app.ip_address.0.ip_address}"
}
output instance_name {
  value = "${google_sql_database_instance.demo_app.name}"
}
output instance_region {
  value = "${google_sql_database_instance.demo_app.region}"
}
# this should be removed probably (duplicate)
output demo_app_grpc_database_instance {
  value = "${google_sql_database_instance.demo_app.name}"
}
# this should be removed probably (duplicate)
output adminer_database_instance {
  value = "${google_sql_database_instance.demo_app.name}"
}

output database_name {
  value = "${google_sql_database.demo_app.name}"
}

output demo_app_grpc_username {
  value = "${google_sql_user.user_demo_app_grpc.name}"
}

output demo_app_grpc_password {
  value = "${google_sql_user.user_demo_app_grpc.password}"
}

output demo_app_grpc_instance {
  value = "${google_sql_user.user_demo_app_grpc.instance}"
}

output adminer_username {
  value = "${google_sql_user.user_adminer.name}"
}

output adminer_password {
  value = "${google_sql_user.user_adminer.password}"
}

output adminer_instance {
  value = "${google_sql_user.user_adminer.instance}"
}
