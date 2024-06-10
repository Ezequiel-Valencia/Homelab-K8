#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="grafana-admin-credentials"
NAMESPACE="monitoring"
read -s -p "Admin Password: " ADMIN_PASSWORD


# Broken on purpose since it has production configurations, remove kubconfig flag to bring it back to test

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=admin-password="${ADMIN_PASSWORD}" \
      --from-literal=admin-user="admin" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --format yaml > ./monitor.yml