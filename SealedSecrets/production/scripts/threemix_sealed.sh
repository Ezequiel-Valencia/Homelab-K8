#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="three-mix-secrets"
NAMESPACE="public-apps"
read -s -p "Postgress Password: " POSTGRES_PASSWORD
echo
read -s -p "Cookie Signing Key: " COOKIE_SIGNING_KEY


kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" \
      --from-literal=COOKIE_SIGNING_KEY="${COOKIE_SIGNING_KEY}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ../three-mix.yml