#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

export KUBECONFIG=/home/zek/.kube/config_prd

SECRET_NAME="gitea-secret"
NAMESPACE="bots"
read -s -p "Gitea DB Password: " DB_PASSWD


# Broken on purpose since it has production configurations, remove kubconfig flag to bring it back to test

kubectl create secret generic ${SECRET_NAME} --dry-run=client \
      --from-literal=GITEA__database__PASSWD="${DB_PASSWD}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ../gitea.yml
