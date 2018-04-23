#!/bin/sh

build_vpn_image () {
  docker build -f $VPN_REPO/Dockerfile -t gcr.io/$GCP_PROJECT/demo-app/vpn:0.0.1 $VPN_REPO
}

push_vpn_image () {
  docker push gcr.io/$GCP_PROJECT/demo-app/vpn:0.0.1
}

build_vpn_image

push_vpn_image

exit 0
