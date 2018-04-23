#!/bin/sh

build_email_relay_image () {
  docker build -f $EMAIL_RELAY_REPO/Dockerfile -t gcr.io/$GCP_PROJECT/demo-app/email/relay:0.0.1 $EMAIL_RELAY_REPO
}

push_email_relay_image () {
  docker push gcr.io/$GCP_PROJECT/demo-app/email/relay:0.0.1
}

build_email_relay_image

push_email_relay_image

exit 0
