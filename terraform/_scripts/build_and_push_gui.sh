#!/bin/sh

build_gui_image () {
  docker build -f $GUI_REPO/Dockerfile -t gcr.io/$GCP_PROJECT/demo-app/gui:0.0.1 $GUI_REPO
}

push_gui_image () {
  docker push gcr.io/$GCP_PROJECT/demo-app/gui:0.0.1
}

build_gui_image

push_gui_image

exit 0
