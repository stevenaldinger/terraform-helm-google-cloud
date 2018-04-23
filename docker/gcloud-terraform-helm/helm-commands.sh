#!/bin/sh

##################################################################
# HELM COMMANDS
##################################################################

helm install -f cache_values.yaml namespaces/cache/ --dry-run --namespace storage
