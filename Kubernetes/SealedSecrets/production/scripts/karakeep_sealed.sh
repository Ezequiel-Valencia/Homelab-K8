#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="karakeep-secrets"
NAMESPACE="bots"
read -s -p "NextAuth Secret: " NEXTAUTH_SECRET
echo

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=NEXTAUTH_SECRET="${NEXTAUTH_SECRET}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ../karakeep-secrets.yml