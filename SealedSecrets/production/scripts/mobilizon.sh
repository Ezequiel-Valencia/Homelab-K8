#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="mobilizon-secret"
NAMESPACE="public-apps"
read -s -p "Secret Key Base: " MOBILIZON_INSTANCE_SECRET_KEY_BASE 
echo
read -s -p "Secret Key: " MOBILIZON_INSTANCE_SECRET_KEY 
echo
read -s -p "DB Password: " DB_PASSWORD

# Broken on purpose since it has production configurations, remove kubconfig flag to bring it back to test

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=MOBILIZON_INSTANCE_SECRET_KEY_BASE="${MOBILIZON_INSTANCE_SECRET_KEY_BASE}" \
      --from-literal=MOBILIZON_INSTANCE_SECRET_KEY="${MOBILIZON_INSTANCE_SECRET_KEY}" \
      --from-literal=MOBILIZON_DATABASE_PASSWORD="${DB_PASSWORD}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ../mobilizon.yml