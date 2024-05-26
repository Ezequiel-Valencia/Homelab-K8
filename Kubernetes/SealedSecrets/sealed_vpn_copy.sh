#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

# validate the number of arguments
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./sealed_secret_api.sh <wireguard_private_key> <wireguard_address> <vpn_service_provider>"
    exit 1
fi

SECRET_NAME="vpn-secrets"
NAMESPACE="media"
OPENVPN_USER=$1
VPN_PROVIDER=$2

# Broken on purpose since it has production configurations, remove kubconfig flag to bring it back to test

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=OPENVPN_USER="${OPENVPN_USER}" \
      --from-literal=VPN_SERVICE_PROVIDER="${VPN_PROVIDER}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --format yaml