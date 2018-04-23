# Google Cloud Platform DevOps

**NOTE:** This is a new project and is not yet ready to be deployed without hiccups but it is modeled after a working project and can be used as a general project template. Project dependencies will be managed as git submodules and will be added as soon as I have time.

Infrastructure Orchestration with Terraform

## Goal of this Project

You should be able to go from having no project at all to having a full stack web app running in multiple clusters (development, staging, production) on Google Kubernetes Engine by setting a few config options and then running a single `terraform apply` command.

The application itself will be deployed using [Helm](https://helm.sh/) and CI/CD will be provided via a [drone server](https://github.com/drone/drone).

An OpenVPN server will be deployed within the cluster allowing you to connect to internal resources and use Kube-DNS from your local machine.

An email relay will be deployed as well to easily integrate with GSuite.

An NGINX deployment will also be deployed and will automatically retrieve an SSL cert from LetsEncrypt (stored in a Google Cloud Storage bucket) and will automatically keep the cert valid.

## Getting started:

This will launch a shell in a docker container that has terraform, gcloud, and helm installed.

The terraform files will be mounted at `/app/terraform` within the container.

1. `cd docker/gcloud-terraform-helm`
2. `./build-docker.sh`
3. `./run-docker.sh`

## Applying Infrastructure Configuration

To apply infrastructure updates:

**NOTE:** Its common to need to run `apply` twice on project creation. This is because it takes Google too long to propagate things like services enablement so the errors you should expect are `40x` around services permissions.

1. Launch the docker container from `Getting started` section above.
2. `cd /app/terraform/_scripts`
3. `./deploy_project.sh`

## Examples of issues during deployment that can be solved by re-running the `deploy_project.sh` script

```
* google_container_cluster.primary: googleapi: Error 403: The Kubernetes Engine API is not enabled for project example-project-200. Please ensure it is enabled in the Google Cloud Console at https://console.cloud.google.com/apis/api/container.googleapis.com/overview?project=example-project-200 and try again., forbidden
```

```
* google_storage_bucket.example-project-200-bucket: googleapi: Error 403: The project to be billed has not configured billing., accountDisabled
```
