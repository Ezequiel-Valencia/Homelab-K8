#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="openweb-secret"
NAMESPACE="ai"
read -s -p "QDRant API Key: " QDRANT_API_KEY
echo
read -s -p "Google Client ID: " GOOGLE_DRIVE_CLIENT_ID
echo
read -s -p "Google API Key: " GOOGLE_DRIVE_API_KEY
echo

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=QDRANT_API_KEY="${QDRANT_API_KEY}" \
      --from-literal=GOOGLE_DRIVE_CLIENT_ID="${GOOGLE_DRIVE_CLIENT_ID}" \
      --from-literal=GOOGLE_DRIVE_API_KEY="${GOOGLE_DRIVE_API_KEY}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ../openweb.yml

