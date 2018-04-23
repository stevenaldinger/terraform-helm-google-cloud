#!/bin/sh

fix_gcloud_rbac_permissions () {
  account=$(gcloud info --format='value(config.account)')

  kubectl create clusterrolebinding owner-cluster-admin-binding \
    --clusterrole cluster-admin \
    --user $account
}

install_prometheus () {
  helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
  helm install coreos/prometheus-operator --name prometheus-operator --set global.rbacEnable=false --set rbacEnable=false --namespace monitoring
  helm install coreos/kube-prometheus --name kube-prometheus --set global.rbacEnable=false --set rbacEnable=false --namespace monitoring
}

fix_gcloud_rbac_permissions

install_prometheus

exit 0
