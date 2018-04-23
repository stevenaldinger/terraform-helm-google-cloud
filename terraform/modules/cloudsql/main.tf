##############################
#    GCP CLOUDSQL SETTINGS   #
##############################

# ------------------------ [START] Database Instances ------------------------ #
resource "google_sql_database_instance" "demo_app" {
  project           = "${var.gcp_project}"
  name              = "${var.cloudsql_database_instance_name}"
  region            = "${var.gcp_region}"
  database_version  = "${var.cloudsql_database_instance_version}"

  settings {
    tier = "db-${var.cloudsql_database_instance_machine_type}"
  }
}
# ------------------------- [END] Database Instances ------------------------- #

# ----------------------------- [START] Databases ---------------------------- #
resource "google_sql_database" "demo_app" {
  project   = "${var.gcp_project}"
  name      = "${var.cloudsql_database_name}"
  instance  = "${google_sql_database_instance.demo_app.name}"
  charset   = "utf8"
  collation = "utf8_general_ci"
}
# ------------------------------ [END] Databases ----------------------------- #

# ------------------------------ [START] Users ------------------------------- #
resource "google_sql_user" "demo_app_grpc" {
  project   = "${var.gcp_project}"
  name      = "${var.cloudsql_user_demo_app_grpc}"
  instance  = "${google_sql_database_instance.demo_app.name}"
  password  = "${var.cloudsql_password_demo_app_grpc}"
}

resource "google_sql_user" "adminer" {
  project   = "${var.gcp_project}"
  name      = "${var.cloudsql_user_adminer}"
  instance  = "${google_sql_database_instance.demo_app.name}"
  password  = "${var.cloudsql_password_adminer}"
}
# ------------------------------- [END] Users -------------------------------- #
