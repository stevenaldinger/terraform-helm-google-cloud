###############################
#    GCP PROJECT VARIABLES    #
###############################

gcp_project = "demo-terraform-project-1234"
gcp_region = "us-east1"
gcp_zone = "us-east1-c"
gcp_organization_id = ""
gcp_billing_account_display_name = "My Billing Account"

###############################
#    GCP STORAGE VARIABLES    #
###############################

bucket_name_demo_app = "terraform-demo-app-db"
bucket_location_demo_app = "US"
bucket_class_demo_app = "MULTI_REGIONAL"

#######################################
#    GCP SERVICE ACCOUNTS VARIABLES   #
#######################################

demo_app_grpc_name           = "demo-app-grpc"
demo_app_grpc_display_name   = "Demo App gRPC Server"
adminer_name                      = "adminer"
adminer_display_name              = "Adminer Server"

###############################
#     CLOUDSQL VARIABLES      #
###############################

cloudsql_database_instance_name = "dev"
cloudsql_database_instance_version = "MYSQL_5_7"
cloudsql_database_instance_machine_type = "n1-standard-1"
cloudsql_database_name = "terraform-demo-app"
cloudsql_user_demo_app_grpc = "demo-app"
cloudsql_password_demo_app_grpc = "my-sensitive-pw!"
cloudsql_user_adminer = "adminer"
cloudsql_password_adminer = "another-sensitive-pw!!"

##############################
#     GCP DISK VARIABLES     #
##############################
vpn_disk_name = "demo-app-vpn"
vpn_disk_type = "pd-standard"
vpn_disk_size = "10"

###############################
#   GCP ADDRESSES VARIABLES   #
###############################
vpn_static_address_name = "demo-app-cluster-vpn"
nginx_static_address_name = "demo-app-cluster-nginx"

###############################
#    GCP CLUSTER VARIABLES    #
###############################

master_admin_username = "P55M57G5h93mNs"
master_admin_password = "3p4NP85a2C69p*jN"
cluster_name = "demo-app"
# https://cloud.google.com/kubernetes-engine/release-notes
kubernetes_version = "1.9.6-gke.0"
kubernetes_node_machine_type = "n1-standard-1"
initial_node_count = 3

##############################
#       HELM VARIABLES       #
##############################
demo_app_gui_image_tag  = "0.0.1"
demo_app_api_image_tag  = "0.0.1"
demo_app_grpc_image_tag = "0.0.1"
