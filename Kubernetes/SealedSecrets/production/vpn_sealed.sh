#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="vpn-secrets"
NAMESPACE="media"

read -s -p "Wireguard Private Key: " WIREGUARD_PRIVATE_KEY
read -s -p "Wireguard Address: " WIREGUARD_ADDRESSES
read -s -p "VPN Service Provider: " VPN_SERVICE_PROVIDER


kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=WIREGUARD_PRIVATE_KEY="${WIREGUARD_PRIVATE_KEY}" \
      --from-literal=SERVER_CITIES="New York NY" \
      --from-literal=WIREGUARD_ADDRESSES="${WIREGUARD_ADDRESSES}" \
      --from-literal=VPN_SERVICE_PROVIDER="${VPN_SERVICE_PROVIDER}" \
      --from-literal=VPN_TYPE="wireguard" \
      --from-literal=DOT_PROVIDERS="quad9" \
      --from-literal=UPDATER_PERIOD="48h" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ./vpn-secrets.yml