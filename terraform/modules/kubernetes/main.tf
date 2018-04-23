##############################
#    GCP CLUSTER SETTINGS    #
##############################

resource "google_container_cluster" "primary" {
  project             = "${var.gcp_project}"
  name                = "${var.cluster_name}"
  zone                = "${var.gcp_zone}"
  initial_node_count  = "${var.initial_node_count}"
  node_version        = "${var.kubernetes_version}"
  min_master_version  = "${var.kubernetes_version}"
  # seems necessary for cluster to spin up successfully in Google
  enable_legacy_abac  = "true"

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  master_auth {
    username = "${var.master_admin_username}"
    password = "${var.master_admin_password}"
  }

  node_config {
    machine_type = "${var.kubernetes_node_machine_type}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "storage-full",
      "compute-rw",
      "cloud-source-repos",
      "https://www.googleapis.com/auth/cloud-platform",
      "service-control",
      "service-management",
      "https://www.googleapis.com/auth/drive",
      "https://www.googleapis.com/auth/plus.login",
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite"
    ]
  }

  # 1. pulls cluster credentials down
  # 2. installs tiller
  # 3. generates openvpn config for cluster > helm/namespaces/vpn/openvpn.conf
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.cluster_name} --zone ${google_container_cluster.primary.zone} --project ${var.gcp_project} && gcloud beta auth configure-docker --quiet && helm init && ../_scripts/build_and_push_vpn.sh && ../_scripts/build_and_push_email_relay.sh && ../_scripts/build_and_push_gui.sh && ../_scripts/build_and_push_grpc.sh && ../_scripts/generate_openvpn_conf.sh $OPENVPN_CONF_TARGET $OPENVPN_HOSTNAME ${var.cluster_name}"

    environment {
      GCP_PROJECT = "${var.gcp_project}"
      GCP_ZONE = "${google_container_cluster.primary.zone}"
      OPENVPN_CONF_TARGET = "../../helm/namespaces/vpn/${var.vpn_config_file}"
      # hostname doesnt really affect anything i dont think
      OPENVPN_HOSTNAME = "vpn.stevenaldinger.com"
      VPN_REPO = "../../repos/openvpn"
      EMAIL_RELAY_REPO = "../../repos/k8s-email-relay"
      GUI_REPO = "../../repos/demo-app-ui"
      GRPC_REPO = "../../repos/demo-app-grpc"
    }
  }
}

provider "helm" {
  # first thing i could think of thats unique
  alias = "${var.vpn_ip_address}"
  kubernetes {
    host = "https://${google_container_cluster.primary.endpoint}"
    username = "${google_container_cluster.primary.master_auth.0.username}"
    password = "${google_container_cluster.primary.master_auth.0.password}"

    //    client_certificate     = "${google_container_cluster.primary.master_auth.0.client_certificate}"
    client_key             = "${google_container_cluster.primary.master_auth.0.client_key}"
    //    cluster_ca_certificate = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
  }
}

resource "helm_release" "cache" {
  provider = "helm.${var.vpn_ip_address}"
  name  = "cache"
  namespace = "cache"
  chart = "../../helm/namespaces/cache"
  values = [
    "${file("../../helm/cache_values.yaml")}"
  ]
}

resource "helm_release" "email" {
  provider = "helm.${var.vpn_ip_address}"
  name  = "email"
  namespace = "email"
  chart = "../../helm/namespaces/email"
  values = [
    "${file("../../helm/email_values.yaml")}"
  ]

  set {
    name = "email.image.repository"
    value = "gcr.io/${var.gcp_project}/demo-app/email/relay"
  }
}

resource "helm_release" "vpn" {
  provider = "helm.${var.vpn_ip_address}"
  name  = "vpn"
  namespace = "vpn"
  chart = "../../helm/namespaces/vpn"
  values = [
    "${file("../../helm/vpn_values.yaml")}"
  ]

  set {
    name  = "openvpn.env.diskName"
    value = "${var.vpn_disk_name}"
  }
  set {
    name  = "openvpn.service.loadBalancerIP"
    value = "${var.vpn_ip_address}"
  }
  set {
    name  = "openvpn.configFile"
    value = "${var.vpn_config_file}"
  }
  set {
    name  = "openvpn.image.repository"
    value = "gcr.io/${var.gcp_project}/demo-app/vpn"
  }
  set {
    name  = "openvpn.image.version"
    value = "0.0.1"
  }
}

resource "helm_release" "demo_app" {
  provider = "helm.${var.vpn_ip_address}"
  name  = "demo-app"
  namespace = "demo-app"
  chart = "../../helm/namespaces/demo_app"
  values = [
    "${file("../../helm/demo_app_values.yaml")}"
  ]

  set {
    name  = "gui.image.version"
    value = "${var.demo_app_gui_image_tag}"
  }
  set {
    name  = "gui.image.repository"
    value = "gcr.io/${var.gcp_project}/demo-app/gui"
  }
  set {
    name  = "api.image.version"
    value = "${var.demo_app_api_image_tag}"
  }
  set {
    name  = "api.image.repository"
    value = "gcr.io/${var.gcp_project}/demo-app/gui"
  }
  set {
    name  = "grpc.image.version"
    value = "${var.demo_app_grpc_image_tag}"
  }
  set {
    name  = "grpc.image.repository"
    value = "gcr.io/${var.gcp_project}/demo-app/grpc"
  }
  set {
    name  = "grpc.env.dbUsername"
    value = "${var.demo_app_grpc_username}"
  }
  set {
    name  = "grpc.env.dbPassword"
    value = "${var.demo_app_grpc_password}"
  }
  set {
    name  = "grpc.env.dbDatabase"
    value = "${var.demo_app_database_name}"
  }
  set {
    name  = "grpc.env.dbInstanceConnection"
    value = "${var.gcp_project}:${var.demo_app_grpc_database_instance_region}:${var.demo_app_grpc_database_instance}=tcp:3306"
  }
}

resource "helm_release" "tools" {
  provider = "helm.${var.vpn_ip_address}"
  name  = "tools"
  namespace = "tools"
  chart = "../../helm/namespaces/tools"
  values = [
    "${file("../../helm/tools_values.yaml")}"
  ]

  set {
    name  = "adminer.env.dbUsername"
    value = "${var.adminer_username}"
  }
  set {
    name  = "adminer.env.dbPassword"
    value = "${var.adminer_password}"
  }
  set {
    name  = "grpc.env.dbName"
    value = "${var.demo_app_database_name}"
  }
  set {
    name  = "grpc.env.dbInstanceConnection"
    value = "${var.gcp_project}:${var.adminer_database_instance}=tcp:3306"
  }
  set {
    name  = "grpc.env.gcpProject"
    value = "${var.gcp_project}"
  }
}
