#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

# validate the number of arguments
if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters"
    echo "Usage: ./sealed_secret_api.sh <wireguard_private_key> <wireguard_address> <vpn_service_provider>"
    exit 1
fi

SECRET_NAME="vpn-secrets"
NAMESPACE="media"
WIREGUARD_PRIVATE_KEY=$1
WIREGUARD_ADDRESSES=$2
VPN_SERVICE_PROVIDER=$3

kubectl create secret generic ${SECRET_NAME} --dry-run=client \
      --from-literal=WIREGUARD_PRIVATE_KEY="${WIREGUARD_PRIVATE_KEY}" \
      --from-literal=SERVER_CITIES="New York NY" \
      --from-literal=WIREGUARD_ADDRESSES="${WIREGUARD_ADDRESSES}" \
      --from-literal=VPN_SERVICE_PROVIDER="${VPN_SERVICE_PROVIDER}" \
      --from-literal=VPN_TYPE="" \
      --from-literal=DOT_PROVIDERS="quad9" \
      --from-literal=UPDATER_PERIOD="48h" \
      --namespace="${NAMESPACE}" -o yaml | kubeseal --format yaml