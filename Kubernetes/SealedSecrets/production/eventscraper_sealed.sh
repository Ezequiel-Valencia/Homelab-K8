#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="eventscraper-secrets"
NAMESPACE="bots"
read -s -p "Mobilizon Email: " MOBILIZON_EMAIL
echo
read -s -p "Mobilizon Password: " MOBILIZON_PASSWORD


kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=MOBILIZON_EMAIL="${MOBILIZON_EMAIL}" \
      --from-literal=MOBILIZON_PASSWORD="${MOBILIZON_PASSWORD}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --format yaml > ./eventscraper-secrets.yml