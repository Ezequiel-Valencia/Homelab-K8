#!/usr/bin/env bash

# Before create a .htpasswd file!!!!!!
# https://grafana.com/docs/loki/latest/setup/install/helm/deployment-guides/aws/#loki-basic-authentication


# validate the number of arguments
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./sealed_secret_ghcr.sh <loki_user> <loki_passwd>"
    exit 1
fi

USERNAME=$1
PASSWORD=$2

# Files #

export KUBECONFIG=/home/zek/.kube/config_prd

#-------------Login Secret-------------!#

htpasswd -cib ./secrets/.htpasswd ${USERNAME} ${PASSWORD}

kubectl create secret generic loki-htp-file --dry-run=client \
    --from-file=./secrets/.htpasswd -n monitoring -o yaml | kubeseal --format yaml \
    --controller-namespace=kube-system \
    --controller-name=sealed-secrets > ./secrets/loki-htpasswd.yml


kubectl create secret generic loki-login --dry-run=client \
      --from-literal=LOKI_USERNAME="${USERNAME}" \
      --from-literal=LOKI_PASSWD="${PASSWORD}" \
      --namespace="monitoring" -o yaml | kubeseal --format yaml \
      --controller-namespace=kube-system \
        --controller-name=sealed-secrets > ./secrets/loki-login-secret-logging.yml
