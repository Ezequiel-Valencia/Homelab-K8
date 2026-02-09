#!/usr/bin/env bash

SECRET_NAME="leantime-secrets"
NAMESPACE="bots"
read -p "Database Username: " DB_USERNAME
read -s -p "Database Password: " DB_PASSWORD
echo
read -p "Database Name: " DB_NAME
read -s -p "Session ID Password: " SESSION_PASSWORD

kubectl create secret generic ${SECRET_NAME} --dry-run=client \
      --from-literal=LEAN_DB_DATABASE="${DB_NAME}" \
      --from-literal=LEAN_DB_USER="${DB_USERNAME}" \
      --from-literal=LEAN_DB_PASSWORD="${DB_PASSWORD}" \
      --from-literal=MYSQL_ROOT_PASSWORD="${DB_PASSWORD}" \
      --from-literal=LEAN_SESSION_PASSWORD="${SESSION_PASSWORD}" \
      --from-literal=MYSQL_PASSWORD="${DB_PASSWORD}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > leantime.yml