# FROM alpine:3.6
# need glibc for helm terraform provider
FROM frolvlad/alpine-glibc:alpine-3.7

ENV \
 CLOUDSDK_PYTHON_SITEPACKAGES="1" \
 CLOUD_SDK_VERSION="197.0.0" \
 PATH="/usr/bin/google-cloud-sdk/bin:$PATH"

RUN apk add --update --no-cache --virtual .dl-and-install-deps \
          ca-certificates \
          curl \
          docker \
          graphviz \
          jq \
          libcurl \
          libssh2 \
          unzip \
          tar \
 # && curl -Lo /tmp/docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz \
 # && mkdir -p /usr/bin/docker \
 # && tar zxvf /tmp/docker.tgz -C /usr/bin/docker \
 # && rm -rf /tmp/docker.tgz \
 # && apk del .dl-and-install-deps \
 # && addgroup -g 1001 -S docker \
 # && chown -R root:docker /usr/bin/docker \
 # && usermod -a -G docker root
 && apk add --update --no-cache --virtual .gcloud-install-deps \
          bash \
          curl \
          git \
          py-crcmod \
          python \
          openssh-client \
 && curl -Lo /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
 && tar xzfv /tmp/google-cloud-sdk.tar.gz -C /usr/bin/ \
 && rm /tmp/google-cloud-sdk.tar.gz \
 && gcloud config set core/disable_usage_reporting true \
 && gcloud config set component_manager/disable_update_check true \
 && gcloud components install beta kubectl \
 && apk add --no-cache shadow \
 && curl -Lo /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip \
 && unzip /tmp/terraform.zip \
 && mv terraform /usr/local/bin/ \
 && curl -Lo /tmp/helm.tar.gz https://kubernetes-helm.storage.googleapis.com/helm-v2.8.2-linux-amd64.tar.gz \
 && tar xzvf /tmp/helm.tar.gz -C /tmp/ \
 && mv /tmp/linux-amd64/helm /usr/bin/ \
 && rm -rf /tmp/*
 # && gcloud version \
 # && kubectl version

# COPY config/entrypoint.sh /usr/bin/entrypoint

COPY install_helm_provider.sh /usr/bin/install_helm_provider.sh

RUN /usr/bin/install_helm_provider.sh

ENTRYPOINT /bin/sh
