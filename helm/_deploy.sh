#!/bin/sh

install_cache () {
  helm install -f cache_values.yaml namespaces/cache/ --namespace cache
}

install_demo_app () {
  helm install -f demo_app_values.yaml namespaces/demo_app/ --namespace demo-app
}

install_email () {
  helm install -f email_values.yaml namespaces/email/ --namespace email
}

install_tools () {
  helm install -f tools_values.yaml namespaces/tools/ --namespace tools
}

install_tools
