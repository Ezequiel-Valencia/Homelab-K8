#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="semaphore-secrets"
NAMESPACE="monitoring"
read -s -p "DB Password: " SEMAPHORE_DB_PASS
echo
read -s -p "Semaphore Access Key (Key for encrypting DB): " SEMAPHORE_ACCESS_KEY_ENCRYPTION
echo
read -s -p "Semaphore Admin Password: " SEMAPHORE_ADMIN_PASSWORD


# Broken on purpose since it has production configurations, remove kubconfig flag to bring it back to test

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=SEMAPHORE_DB_PASS="${SEMAPHORE_DB_PASS}" \
      --from-literal=SEMAPHORE_ACCESS_KEY_ENCRYPTION="${SEMAPHORE_ACCESS_KEY_ENCRYPTION}" \
      --from-literal=SEMAPHORE_ADMIN_PASSWORD="${SEMAPHORE_ADMIN_PASSWORD}" \
      --from-literal=POSTGRES_PASSWORD="${SEMAPHORE_DB_PASS}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ../semaphore.yml