##########################################
#            ALL ENVIRONMENTS            #
##########################################

module "project" {
  source = "../modules/project"
  # IF WE WANT TO USE A SEPARATE PROJECT FOR EACH ENVIRONMENT
  # gcp_project                       = "${var.gcp_project}-${var.env}"
  gcp_project                       = "${var.gcp_project}"
  gcp_region                        = "${var.gcp_region}"
  gcp_billing_account_display_name  = "${var.gcp_billing_account_display_name}"
  gcp_organization_id               = "${var.gcp_organization_id}"
}

module "service_accounts" {
  source = "../modules/service_accounts"
  gcp_project                       = "${module.project.name}"
  demo_app_grpc_name           = "${var.demo_app_grpc_name}"
  demo_app_grpc_display_name   = "${var.demo_app_grpc_display_name}"
  adminer_name                      = "${var.adminer_name}"
  adminer_display_name              = "${var.adminer_display_name}"
}

module "iam" {
  source = "../modules/iam"
  gcp_project                   = "${module.project.name}"
  demo_app_grpc_email      = "${module.service_accounts.demo_app_grpc_email}"
  adminer_email                 = "${module.service_accounts.adminer_email}"
}

module "persistent_disks_dev" {
  source = "../modules/persistent_disks"
  gcp_project   = "${module.project.name}"
  gcp_zone      = "${var.gcp_zone}"
  vpn_disk_name = "${var.vpn_disk_name}"
  vpn_disk_type = "${var.vpn_disk_type}"
  vpn_disk_size = "${var.vpn_disk_size}"
}

module "persistent_disks_staging" {
  source = "../modules/persistent_disks"
  gcp_project   = "${module.project.name}"
  gcp_zone      = "${var.gcp_zone}"
  vpn_disk_name = "${var.vpn_disk_name}-staging"
  vpn_disk_type = "${var.vpn_disk_type}"
  vpn_disk_size = "${var.vpn_disk_size}"
}

module "addresses_dev" {
  source = "../modules/addresses"
  gcp_project               = "${module.project.name}"
  gcp_region                = "${var.gcp_region}"
  vpn_static_address_name   = "${var.vpn_static_address_name}"
  nginx_static_address_name = "${var.nginx_static_address_name}"
}

module "addresses_staging" {
  source = "../modules/addresses"
  gcp_project               = "${module.project.name}"
  gcp_region                = "${var.gcp_region}"
  vpn_static_address_name   = "${var.vpn_static_address_name}-staging"
  nginx_static_address_name = "${var.nginx_static_address_name}-staging"
}

module "cloudsql" {
  source = "../modules/cloudsql"
  gcp_project                             = "${module.project.name}"
  gcp_region                              = "${var.gcp_region}"
  cloudsql_database_instance_name         = "${var.cloudsql_database_instance_name}"
  cloudsql_database_instance_version      = "${var.cloudsql_database_instance_version}"
  cloudsql_database_instance_machine_type = "${var.cloudsql_database_instance_machine_type}"
  cloudsql_database_name                  = "${var.cloudsql_database_name}"
  cloudsql_user_demo_app_grpc        = "${var.cloudsql_user_demo_app_grpc}"
  cloudsql_password_demo_app_grpc    = "${var.cloudsql_password_demo_app_grpc}"
  cloudsql_user_adminer                   = "${var.cloudsql_user_adminer}"
  cloudsql_password_adminer               = "${var.cloudsql_password_adminer}"
}

module "storage" {
  source = "../modules/storage"
  gcp_project                               = "${module.project.name}"
  bucket_name_demo_app     = "${var.bucket_name_demo_app}"
  bucket_location_demo_app = "${var.bucket_location_demo_app}"
  bucket_class_demo_app    = "${var.bucket_class_demo_app}"
}

module "kubernetes_development" {
  source = "../modules/kubernetes"
  gcp_project                   = "${module.project.name}"
  gcp_zone                      = "${var.gcp_zone}"
  cluster_name                  = "${var.cluster_name}"
  initial_node_count            = "${var.initial_node_count}"
  kubernetes_version            = "${var.kubernetes_version}"
  kubernetes_node_machine_type  = "${var.kubernetes_node_machine_type}"
  master_admin_username         = "${var.master_admin_username}"
  master_admin_password         = "${var.master_admin_password}"
  vpn_disk_name                 = "${module.persistent_disks_dev.name}"
  demo_app_gui_image_tag   = "${var.demo_app_gui_image_tag}"
  demo_app_api_image_tag   = "${var.demo_app_api_image_tag}"
  demo_app_grpc_image_tag  = "${var.demo_app_grpc_image_tag}"
  vpn_ip_address                = "${module.addresses_dev.vpn_static_address_name}"
  nginx_ip_address              = "${module.addresses_dev.nginx_static_address_name}"

  demo_app_grpc_username                 = "${module.cloudsql.demo_app_grpc_username}"
  demo_app_grpc_password                 = "${module.cloudsql.demo_app_grpc_password}"
  demo_app_grpc_database_instance        = "${module.cloudsql.demo_app_grpc_database_instance}"
  demo_app_grpc_database_instance_region = "${module.cloudsql.instance_region}"
  demo_app_database_name                 = "${module.cloudsql.database_name}"

  adminer_username          = "${module.cloudsql.adminer_username}"
  adminer_password          = "${module.cloudsql.adminer_password}"
  adminer_database_instance = "${module.cloudsql.adminer_database_instance}"

  # path relative to the helm chart.
  # this allows for multiple clusters
  vpn_config_file = "openvpn.conf"
}

module "kubernetes_staging" {
  source = "../modules/kubernetes"
  gcp_project                   = "${module.project.name}"
  gcp_zone                      = "${var.gcp_zone}"
  cluster_name                  = "${var.cluster_name}-staging"
  initial_node_count            = "${var.initial_node_count}"
  kubernetes_version            = "${var.kubernetes_version}"
  kubernetes_node_machine_type  = "${var.kubernetes_node_machine_type}"
  master_admin_username         = "${var.master_admin_username}"
  master_admin_password         = "${var.master_admin_password}"
  vpn_disk_name                 = "${module.persistent_disks_staging.name}"
  demo_app_gui_image_tag   = "${var.demo_app_gui_image_tag}"
  demo_app_api_image_tag   = "${var.demo_app_api_image_tag}"
  demo_app_grpc_image_tag  = "${var.demo_app_grpc_image_tag}"
  vpn_ip_address                = "${module.addresses_staging.vpn_static_address_name}"
  nginx_ip_address              = "${module.addresses_staging.nginx_static_address_name}"

  demo_app_grpc_username                 = "${module.cloudsql.demo_app_grpc_username}"
  demo_app_grpc_password                 = "${module.cloudsql.demo_app_grpc_password}"
  demo_app_grpc_database_instance        = "${module.cloudsql.demo_app_grpc_database_instance}"
  demo_app_grpc_database_instance_region = "${module.cloudsql.instance_region}"
  demo_app_database_name                 = "${module.cloudsql.database_name}"

  adminer_username          = "${module.cloudsql.adminer_username}"
  adminer_password          = "${module.cloudsql.adminer_password}"
  adminer_database_instance = "${module.cloudsql.adminer_database_instance}"

  # path relative to the helm chart.
  # this allows for multiple clusters
  vpn_config_file = "openvpn_staging.conf"
}
