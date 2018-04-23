#!/bin/sh

# create project

current_dir="$(pwd)"
terraform_project_dir="$current_dir/../project"
variables_file="$terraform_project_dir/main.tfvars"
plan_output_file="$terraform_project_dir/output.tfplan"

login_application_default () {
  gcloud auth application-default login
}

initialize_terraform_project () {
  cd "$terraform_project_dir"
  terraform init
  cd "$current_dir"
}

plan_project_project () {
  cd "$terraform_project_dir"
  terraform plan "--var-file=$variables_file" "-out=$plan_output_file"
  cd "$current_dir"
}

apply_project () {
  cd "$terraform_project_dir"
  # terraform apply -auto-approve "--var-file=$variables_file"
  terraform apply "$plan_output_file"
  cd "$current_dir"
}

delete_project () {
  cd "$terraform_project_dir"
  terraform destroy -force "--var-file=$variables_file"
  cd "$current_dir"
}

# login_application_default

deploy () {
  initialize_terraform_project
  plan_project_project
  apply_project
}

deploy
# delete_project

cd "$current_dir"

exit 0
