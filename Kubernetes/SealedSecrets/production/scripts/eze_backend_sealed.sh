#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="ezequiel-backend-secrets"
NAMESPACE="public-apps"
read -s -p "Postgress Password: " POSTGRES_PASSWORD
echo
read -s -p "Database URL: " DB_URL
echo 
read -s -p "Database Username: " DB_USERNAME
echo
read -s -p "Slack Webhook: " SLACK_WEBHOOK
echo

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" \
      --from-literal=DB_URL="${DB_URL}" \
      --from-literal=DB_USERNAME="${DB_USERNAME}" \
      --from-literal=SLACK_WEBHOOK="${SLACK_WEBHOOK}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ../ezequiel-backend.yml

