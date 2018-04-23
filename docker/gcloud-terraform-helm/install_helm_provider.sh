#!/bin/sh

set -x

helm_provider_version="0.5.0"
plugins_directory="../development/.terraform/plugins/linux_amd64/"
tarball_target="/tmp/terraform-provider-helm.tar.gz"

download_release () {
  curl -Lo "$tarball_target" \
    https://github.com/mcuadros/terraform-provider-helm/releases/download/v$helm_provider_version/terraform-provider-helm_v${helm_provider_version}_linux_amd64.tar.gz
}

extract_binary () {
  tar -xzvf "$tarball_target" -C /tmp
}

delete_tarball () {
  rm -rf "$tarball_target"
}

ensure_plugins_dir_exists () {
  mkdir -p "$plugins_directory"
}

install_helm_provider_plugin () {
  mv -f /tmp/terraform-provider-helm*/terraform-provider-helm "$plugins_directory"
}

clean_up () {
  rm -rf /tmp/terraform-provider-helm*
}

download_release
extract_binary
delete_tarball
ensure_plugins_dir_exists
install_helm_provider_plugin
clean_up

set +x

exit 0
