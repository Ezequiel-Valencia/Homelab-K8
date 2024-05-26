#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="cloudflare-token-secret"
NAMESPACE="cert-manager"
read -s -p "Cert Token: " CERT_TOKEN


# Broken on purpose since it has production configurations, remove kubconfig flag to bring it back to test

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=cloudflare-token="${CERT_TOKEN}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --format yaml