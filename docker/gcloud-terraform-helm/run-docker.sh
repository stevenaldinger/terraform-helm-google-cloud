#!/bin/sh

docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/../../terraform:/app/terraform \
  -v $(pwd)/../../helm:/app/helm \
  -v $(pwd)/../../repos:/app/repos \
  -v $HOME/.config:/root/.config gcr.io/steven-aldinger/gcloud-terraform-helm:0.0.1
