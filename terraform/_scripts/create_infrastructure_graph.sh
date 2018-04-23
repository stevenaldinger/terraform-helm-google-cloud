#!/bin/sh

current_dir="$(pwd)"
terraform_project_dir="$current_dir/../project"
graph_svg="$current_dir/graph.html"
variables_file="$terraform_project_dir/main.tfvars"
plan_output_file="$terraform_project_dir/output.tfplan"

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

create_graph () {
  cd "$terraform_project_dir"
  terraform graph "$plan_output_file" | dot -Tsvg > "$graph_svg"
  cd "$current_dir"
}

run_create_graph () {
  initialize_terraform_project
  plan_project_project
  create_graph
}

run_create_graph

cd "$current_dir"

exit 0
