######################################
#    GCP SERVICE ACCOUNTS SETTINGS   #
######################################

resource "google_service_account" "demo_app_grpc" {
  project      = "${var.gcp_project}"
  account_id   = "${var.demo_app_grpc_name}"
  display_name = "${var.demo_app_grpc_display_name}"
}

resource "google_service_account_key" "demo_app_grpc_key" {
  service_account_id = "${google_service_account.demo_app_grpc.name}"

  provisioner "local-exec" {
    command = "echo $DEMO_APP_GRPC_PRIVATE_KEY | base64 -d > $DEMO_APP_GRPC_TARGET_FILE"

    environment {
      DEMO_APP_GRPC_PRIVATE_KEY = "${google_service_account_key.demo_app_grpc_key.private_key}"
      DEMO_APP_GRPC_TARGET_FILE = "../../helm/namespaces/demo_app/credentials.json"
    }
  }
}

resource "google_service_account" "adminer" {
  project      = "${var.gcp_project}"
  account_id   = "${var.adminer_name}"
  display_name = "${var.adminer_display_name}"
}

resource "google_service_account_key" "adminer_key" {
  service_account_id = "${google_service_account.adminer.name}"

  provisioner "local-exec" {
    command = "echo $ADMINER_PRIVATE_KEY | base64 -d > $ADMINER_TARGET_FILE"

    environment {
      ADMINER_PRIVATE_KEY = "${google_service_account_key.adminer_key.private_key}"
      ADMINER_TARGET_FILE = "../../helm/namespaces/tools/credentials.json"
    }
  }
}
