#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="eventscraper-secrets"
NAMESPACE="bots"
read -s -p "Mobilizon Email: " MOBILIZON_EMAIL
echo
read -s -p "Mobilizon Password: " MOBILIZON_PASSWORD
echo
read -s -p "Slack Webhook: " SLACK_WEBHOOK


kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=MOBILIZON_EMAIL="${MOBILIZON_EMAIL}" \
      --from-literal=MOBILIZON_PASSWORD="${MOBILIZON_PASSWORD}" \
      --from-literal=SLACK_WEBHOOK="${SLACK_WEBHOOK}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --format yaml > ./eventscraper-secrets.yml